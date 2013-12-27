/*
 Mediator - PureMVC
 */
package com.octadecimal.nodebend.view 
{
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.WorldLayerView;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.nodebend.view.*;
	
	/**
	 * A Mediator
	 */
	public class WorldLayerMediator extends Mediator implements IMediator 
	{
		/**
		 * This layer's index in the world layer stack. Used as a string for
		 * better cohesion with passing around notification types. Will need to be
		 * casted when used as an array offset.
		 */
		private var _index:String = "0";
		
		/**
		 * World position.
		 */
		public function get x():Number { return view.x; }
		public function get y():Number { return view.y; }
		private var _x:Number, _y:Number;
		
		
		/**
		 * Constructor.
		 */
		public function WorldLayerMediator(name:String, initialIndex:String, viewComponent:Object) {
			_index = initialIndex;
			super(name, viewComponent);
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			Nodebend.debug(this, "Created. " + _index + "->" + id);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Listen for view stage mouse events
			view.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onStageMiddleDown);
			view.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onStageMiddleUp);
			view.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onStageWheel);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onStageMiddleDown(e:MouseEvent):void 
		{
			// Drag layer view if world's input is not blocked
			if(!world.blockInput) view.startDrag();
		}
		
		private function onStageMiddleUp(e:MouseEvent):void 
		{
			// Stop dragging layer view
			view.stopDrag();
		}
		
		private function onStageWheel(e:MouseEvent):void 
		{
			// Pan camera
			camera.panToMouse();
		}
		
		
		
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Nodebend.ADD_TO_WORLD_LAYER, Nodebend.ADD_TO_WORLD_LAYER_UNDER, Nodebend.REMOVE_FROM_WORLD_LAYER];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName())  {           	
				
				case Nodebend.ADD_TO_WORLD_LAYER:
					
					if (_index == note.getType()) {
						view.addChild(note.getBody() as DisplayObject);
						Nodebend.debug(this, "Adding to world layer ("+_index+"): " + note.getBody());
					}
					break;
				
				
				case Nodebend.ADD_TO_WORLD_LAYER_UNDER:
					
					if (_index == note.getType()) {
						view.addChildAt(note.getBody() as DisplayObject, 0);
						Nodebend.debug(this, "Adding to world layer ("+_index+"): " + note.getBody());
					}
					break;
				
				
				case Nodebend.REMOVE_FROM_WORLD_LAYER:
					
					//if (_index == note.getType()) {
						view.removeChild(note.getBody() as DisplayObject);
						Nodebend.debug(this, "Removing from world layer ("+_index+"): " + note.getBody());
					//}
					break;
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessors.
		 */
		public function get  id()     : String 			{ return getMediatorName(); }
		private function get view()   : WorldLayerView 	{ return viewComponent as WorldLayerView}
		private function get world()  : WorldMediator 	{ if (!_world) _world = facade.retrieveMediator(WorldMediator.NAME) as WorldMediator; return _world; }
		private function get camera() : CameraMediator 	{ if (!_camera) _camera = facade.retrieveMediator(CameraMediator.NAME) as CameraMediator; return _camera; }
		
		// Cache
		private var _world:WorldMediator;
		private var _camera:CameraMediator;

	}
}
