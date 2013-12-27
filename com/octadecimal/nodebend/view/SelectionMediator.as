/*
 Mediator - PureMVC
 */
package com.octadecimal.nodebend.view 
{
	import com.octadecimal.nodebend.model.List;
	import com.octadecimal.nodebend.model.NodeProxy;
	import com.octadecimal.nodebend.model.vo.PositionVO;
	import com.octadecimal.nodebend.model.vo.SelectionVO;
	import com.octadecimal.nodebend.model.WorldProxy;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.NodeView;
	import com.octadecimal.nodebend.view.components.ShapeView;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.nodebend.view.*;
	
	/**
	 * A Mediator
	 */
	public class SelectionMediator extends Mediator implements IMediator 
	{
		// Selection items (ids)
		//private var _items:Vector.<String> = new Vector.<String>();
		private var _items:List = new List();
		
		// Start position of selection
		private var _startPosition:PositionVO;
		
		// If this selection has been completed (the user let go of the mouse)
		private var _completed:Boolean = false;
		
		
		public function SelectionMediator(name:String, startPosition:PositionVO, viewComponent:Object) {
			super(name, viewComponent);
			_startPosition = startPosition;
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Move view to start position
			view.x = _startPosition.x;
			view.y = _startPosition.y;
			
			// Listen for stage mouse events
			with (StageMediator(facade.retrieveMediator(StageMediator.NAME)).getViewComponent() as Stage)
			{
				addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (!_completed) {
				view.setSize(e.stageX - _startPosition.x, e.stageY - _startPosition.y);
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if (_completed) return;
			
			// Hit test
			var node:Mediator, nodeView:DisplayObject;
			var worldP:WorldProxy = facade.retrieveProxy(WorldProxy.NAME) as WorldProxy;
			var world:WorldMediator = facade.retrieveMediator(WorldMediator.NAME) as WorldMediator;
			for each(var nodeID:String in worldP.nodes)
			{
				node = facade.retrieveMediator(nodeID) as Mediator;
				nodeView = node.getViewComponent() as DisplayObject;
				
				if (view.hitTestObject(nodeView))
				{
					// Add to selection
					if (stage.shiftDown)
						facade.sendNotification(Nodebend.ADD_TO_SELECTION, new SelectionVO(world.activeSelection, nodeID));
					
					// Remove from selection
					if (stage.altDown)
						facade.sendNotification(Nodebend.REMOVE_FROM_SELECTION, new SelectionVO(world.activeSelection, nodeID));
					
					// No keyboard modifiers, create new selection
					else
						facade.sendNotification(Nodebend.SELECTED, nodeID);
				}
			}
			
			// Send selection completed note
			facade.sendNotification(Nodebend.SELECTION_COMPLETE, id);
			
			// Remove selection view
			sendNotification(Nodebend.REMOVE_FROM_STAGE, view);
			
			// Set as completed
			_completed = true;
		}
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Nodebend.ADD_TO_SELECTION, Nodebend.REMOVE_FROM_SELECTION];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void 
		{
			var vo:SelectionVO = note.getBody() as SelectionVO;
			var selectionID:String = vo.selection as String;
			var childID:String = vo.message as String;
				
			switch (note.getName()) {
				
				case Nodebend.ADD_TO_SELECTION:
					if (id == selectionID) {
						_items.add(id);
						facade.sendNotification(Nodebend.SELECTED, childID);
					}
					break;	
				
				case Nodebend.REMOVE_FROM_SELECTION:
					if(id == selectionID) {
						//_items.remove(id); wtf is this bugging?
						facade.sendNotification(Nodebend.DESELECTED, childID);
						break;
					}
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Node id. (shared with proxy)
		 */
		public function get id():String 			{ return getMediatorName(); }
		private function get view():ShapeView 		{ return viewComponent as ShapeView }
		private function get stage():StageMediator	{ if (!_stage) _stage = StageMediator(facade.retrieveMediator(StageMediator.NAME)); return _stage; }
		
		// Cache
		private var _stage:StageMediator;
	}
}
