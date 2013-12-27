/*
 Mediator - PureMVC
 */
package com.octadecimal.nodebend.view 
{
	import com.octadecimal.nodebend.model.vo.PositionVO;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.model.*;
	import com.octadecimal.nodebend.view.*;
	import com.octadecimal.nodebend.view.components.*;
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * The World mediator.
	 */
	public class WorldMediator extends Mediator implements IMediator 
	{
		/**
		 * Layers list, may later only need to be an array 
		 * of layer names and not references.
		 */
		private var _layers:List = new List();
		
		/**
		 * The active layer's name.
		 */
		public function get activeLayer():String 			{ return _activeLayer; }
		private var _activeLayer:String;
		
		/**
		 * The currently active selection.
		 */
		public function get activeSelection():String		{ return _activeSelection; }
		private var _activeSelection:String;
		
		/**
		 * Set to true if any element has received a mouse down event. 
		 * Allows the world to ignore any input when true.
		 */
		public function get blockInput():Boolean 			{ return _blockInput; }
		public function set blockInput(a:Boolean):void  	{ _blockInput = a; }
		private var _blockInput:Boolean = false;
		
		/**
		 * Set to true when the mouse is down and false when released. This way
		 * a user has to both press the mouse down AND move the mouse before
		 * a selection is created.
		 */
		private var _createSelection:Boolean = false;
		
		/**
		 * Projected mouse coordinates.
		 */
		public function get mouseX():Number 				{ return _mouseX ; }
		public function get mouseY():Number 				{ return _mouseY ; }
		private var _mouseX:int, _mouseY:int;
		
		/**
		 * Cannonical name of the Mediator
		 */
		public static const NAME:String = "WorldMediator";
		override public function getMediatorName():String	{ return WorldMediator.NAME; }
		
		
		/**
		 * Constructor
		 */
		public function WorldMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			Nodebend.debug(this, "Created.");
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			// Remove
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Component stage events
			view.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			view.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.stage.addEventListener(Event.RESIZE, onStageResize);
			
			// Stage events
			stage.getViewComponent().addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			
			// Initially center view
			view.x = view.stage.stageWidth  * 0.5;
			view.y = view.stage.stageHeight * 0.5;
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onWheel(e:MouseEvent):void 
		{
			// Zoom camera
			camera.zoom = e.delta * 0.05;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			// Deselect all if no input
			if (!blockInput && !stage.shiftDown && !stage.altDown) 
				facade.sendNotification(Nodebend.DESELECT_ALL);
			
			// Create selection
			if (!blockInput) 
				_createSelection = true;
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			// Unblock input
			blockInput = false;
			
			// Don't create a selection on move
			_createSelection = false;
		}
		
		private function onStageResize(e:Event):void 
		{
			// Keep world centered
			view.x = view.stage.stageWidth  * 0.5;
			view.y = view.stage.stageHeight * 0.5;
		}
		
		private function onStageMouseMove(e:MouseEvent):void 
		{
			// Get active layer
			var layer:WorldLayerMediator = facade.retrieveMediator(_activeLayer) as WorldLayerMediator;
			
			// Project world mouse coords
			var f:Number = 1 / camera.zoom;
			_mouseX = f * e.stageX - (stage.halfWidth * f) - layer.x;
			_mouseY = f * e.stageY - (stage.halfHeight * f) - layer.y;
			
			// Create selection if mouse is down
			if (_createSelection && !blockInput) {
				facade.sendNotification(Nodebend.SELECTION_CREATE, new PositionVO(e.stageX, e.stageY));
				_createSelection = false;
			}
		}
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Nodebend.ADD_TO_WORLD, Nodebend.ADD_TO_WORLD_UNDER, Nodebend.REMOVE_FROM_WORLD, Nodebend.SET_ACTIVE_LAYER, 
					Nodebend.SELECTION_COMPLETE, Nodebend.DESELECT_ALL];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) 
			{
				case Nodebend.ADD_TO_WORLD:
				
					Nodebend.debug(this, "Adding to world: " + note.getBody());
					view.addChild(note.getBody() as DisplayObject);
					break;
				
				
				case Nodebend.ADD_TO_WORLD_UNDER:
				
					Nodebend.debug(this, "Adding to world: " + note.getBody());
					view.addChildAt(note.getBody() as DisplayObject, 0);
					break;		
				
				
				case Nodebend.REMOVE_FROM_WORLD: 
				
					Nodebend.debug(this, "Removing from world: " + note.getBody());
					view.removeChild(note.getBody() as DisplayObject);
					break;
				
				
				case Nodebend.SET_ACTIVE_LAYER: 
				
					Nodebend.debug(this, "Setting active layer: " + note.getBody());
					_activeLayer = note.getBody() as String;
					break;
				
				
				case Nodebend.SELECTION_COMPLETE: 
				
					if(!stage.altDown && !stage.shiftDown) {
						Nodebend.debug(this, "Setting active selection: " + note.getBody());
						_activeSelection = note.getBody() as String;
					}
					break;
				
				
				case Nodebend.DESELECT_ALL:
				
					_activeSelection = null
					break;
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessors.
		 */
		private function get view():WorldView 			{ return viewComponent as WorldView }
		private function get camera():CameraMediator	{ if (!_camera) _camera = facade.retrieveMediator(CameraMediator.NAME) as CameraMediator; return _camera; }
		public function get stage():StageMediator		{ if (!_stage) _stage = StageMediator(facade.retrieveMediator(StageMediator.NAME))/*.getViewComponent() as Stage*/; return _stage; }	
		
		// Cache
		private var _camera:CameraMediator;
		private var _stage:StageMediator;
	}
}
