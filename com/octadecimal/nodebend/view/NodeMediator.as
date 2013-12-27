/*
 Mediator - PureMVC
 */
package com.octadecimal.nodebend.view 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import com.octadecimal.nodebend.model.vo.SelectionVO;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.*;
	import com.octadecimal.nodebend.view.components.NodeView;
	import com.octadecimal.nodebend.model.vo.ConnectionVO;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * The Node Mediator.
	 */
	public class NodeMediator extends Mediator implements IMediator 
	{
		/**
		 * When any node is clicked, a connection is created via CONNECTION_CREATE. 
		 * When the connection has been created, the CONNECTION_STARTED notification 
		 * is sent. All nodes listen for this notification, and when it's received, 
		 * it's _receivingConnections is set to true. If a mouseup on this node is received
		 * while  _receivingConnections is true, then the user completed a connection
		 * on this node. It also means the connection's input is set to this node.
		 */
		private var _receivingConnections:Boolean = false;
		
		/**
		 * Set to true (via notification->[de]select()) if selected.
		 */
		private var _selected:Boolean = false;
		
		/**
		 * Set to true if node was moved, used to prevent selecting an object
		 * after dragging has occured.
		 */
		private var _moved:Boolean = false;
		
		/**
		 * Used in conjunction with _moved. Allows for _moved being set to true
		 * only if the mouse is down AND moved.
		 */
		private var _mouseDown:Boolean = false;
		
		
		/**
		 * Constructor
		 */
		public function NodeMediator(name:String, viewComponent:Object) {
			super(name, viewComponent);
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * Dispatched when the view component has been added to the stage.
		 */
		private function onAddedToStage(e:Event):void 
		{
			// Remove
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// View stage
			with (view.stage) {
				addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			}
			// View
			with (view) {
				addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleClick);
			}
			// View edges
			with (view.edges) {
				addEventListener(MouseEvent.MOUSE_DOWN, onEdgesDown);
				addEventListener(MouseEvent.MOUSE_OVER, onEdgesOver);
				addEventListener(MouseEvent.MOUSE_OUT, onEdgesOut);
			}
			// View body
			with (view.body) {
				addEventListener(MouseEvent.MOUSE_DOWN, onBodyDown);
				addEventListener(MouseEvent.MOUSE_UP, onBodyUp);
			}
			
			// Fade in (this should probably go in view component with an exposed api call
			var camera:CameraMediator = facade.retrieveMediator(CameraMediator.NAME) as CameraMediator;
			view.alpha = 0; view.scaleX = view.scaleY = camera.zoom - 1;
			TweenLite.to(view, .15, { alpha: 1, scaleX: 1, scaleY: 1, ease: Back.easeOut } );
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onMouseUp(e:MouseEvent):void 
		{
			// If _receivingConnections is true, it means that a connection, to this node has been made.
			if (_receivingConnections) {
				facade.sendNotification(Nodebend.CONNECTION_FINISHED, id);
				Nodebend.debug(this, "Connection closed on: " + id);
			}
			
			// Reset edge highlighting that occurs when dropping a connection onto this node (if any).
			if (_selected) view.setEdgesColor(Colors.NODE_SELECTED);
			else view.setEdgesColor(Colors.NODE_EDGES);
			view.setBorder(5);
			
			// Not moved and mouse was initially down on this node
			if (!_moved && _mouseDown) 
			{
				// Add to active selection
				if (world.stage.shiftDown)
					facade.sendNotification(Nodebend.ADD_TO_SELECTION, new SelectionVO(world.activeSelection, id));
				
				// Remove from active selection
				else if (world.stage.altDown) {
					Nodebend.debug(this, "Sending removal for: " + id);
					facade.sendNotification(Nodebend.REMOVE_FROM_SELECTION, new SelectionVO(world.activeSelection, id));
				}
				
				// Deselect all
				else facade.sendNotification(Nodebend.DESELECT_ALL);
				
				// Select
				select();
			}
			
			// Reset state
			_moved = false;
			_mouseDown = false;
			
			// Unblock world input
			world.blockInput = false;
		}
		
		private function onStageMouseUp(e:Event):void 
		{
			// Stop watching movement
			view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			// Start watching movement
			view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			// Save mousedown state
			_mouseDown = true;
			
			// Block world input
			world.blockInput = true;
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			// Set moved state if mouse is down
			if (_mouseDown) _moved = true;
			
			// Update connection views if the user is moving this node
			sendNotification(Nodebend.CONNECTION_UPDATE, null, id);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			// Highlight edges if currently holding a connection over this node.
			if (_receivingConnections) { 
				//if (_selected) view.setEdgesColor(Colors.NODE_SELECTED_OVER);  
				/*else*/ view.setEdgesColor(view.color);  
				view.setBorder(5); 
			}
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
		}
		
		private function onMiddleClick(e:MouseEvent):void 
		{
			// Center camera on this node
			var camera:CameraMediator = facade.retrieveMediator(CameraMediator.NAME) as CameraMediator;
			camera.panToMouse();
		}
		
		private function onEdgesDown(e:MouseEvent):void 
		{
			// send CONNECTION_CREATE notification, creating a new connection
			facade.sendNotification(Nodebend.CONNECTION_CREATE, new ConnectionVO(id));
			
			// Save mousedown state
			_mouseDown = true;
		}
		
		private function onEdgesOver(e:MouseEvent):void 
		{
			// Set edges over visual state
			if (_selected) view.setEdgesColor(Colors.NODE_SELECTED_OVER);
			else view.setEdgesColor(Colors.NODE_EDGES_OVER);
			//view.setBorder(10);
		}
		
		private function onEdgesOut(e:MouseEvent):void 
		{
			/* BUG: For some reason this code is preventing the color
			 * from being changed when the user deselects a single node. 
			 * The node deselects, but the colors do not update. 
			 */
			if (_selected) view.setEdgesColor(Colors.NODE_SELECTED);
			else view.setEdgesColor(Colors.NODE_EDGES); 
			view.setBorder(5);
		}
		
		private function onBodyDown(e:MouseEvent):void 
		{
			// Drag view
			view.startDrag();
			
			// Save mousedown state
			_mouseDown = true;
		}
		
		private function onBodyUp(e:MouseEvent):void 
		{
			// Stop dragging view
			view.stopDrag();
		}
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		private function select():void
		{
			// Set selection color
			view.setEdgesColor(Colors.NODE_SELECTED);
			
			// Set selected state
			_selected = true;
		}
		
		private function deselect():void
		{
			// Set selection color
			view.setEdgesColor(Colors.NODE_EDGES);
			
			// Unset selected state
			_selected = false;
		}
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Nodebend.SELECTED, Nodebend.DESELECTED, Nodebend.DESELECT_ALL, Nodebend.CONNECTION_STARTED, Nodebend.CONNECTION_CANCEL, Nodebend.CONNECTION_FINISHED];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				
				// The user has selected a node
				case Nodebend.SELECTED:
					if (String(note.getBody()) == id) select();
					break;
				
				// The user has deselected
				case Nodebend.DESELECTED:
					if (String(note.getBody()) == id) deselect();
					break;
				
				// The user has deselected
				case Nodebend.DESELECT_ALL:
					deselect();
					break;
				
				// A connection has been started, listen for connections to this node.
				case Nodebend.CONNECTION_STARTED:
					_receivingConnections = true;
					break;
					
				// A connection has been canceled, so stop listening for connections to this node.
				case Nodebend.CONNECTION_CANCEL:
					_receivingConnections = false;
					break;
					
				// A connection has been completed (somewhere), so stop listening for connections to this node.
				case Nodebend.CONNECTION_FINISHED:
					_receivingConnections = false;
					break;
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessors.
		 */
		public function get id():String { return getMediatorName(); }
		private function get view():NodeView { return viewComponent as NodeView }
		private function get world():WorldMediator { if (!_world) _world = facade.retrieveMediator(WorldMediator.NAME) as WorldMediator; return _world; }
		
		// Cache
		private var _world:WorldMediator;

	}
}
