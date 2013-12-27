/*
 Mediator - PureMVC
 */
package com.octadecimal.nodebend.view 
{
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.WorldLayerView;
	import com.octadecimal.nodebend.view.components.WorldView;
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.nodebend.view.*;
	
	/**
	 * A Mediator
	 */
	public class CameraMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "Camera";
		
		private var _zoom:Number = 1.0;
		
		
		public function CameraMediator() {
			super(NAME); 
			Nodebend.debug(this, "Created.");
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String {
			return CameraMediator.NAME;
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		public function set zoom(increment:Number):void {
			zoomTo(_zoom + increment);
		}
		public function get zoom():Number { return _zoom; }
		
		public function zoomTo(value:Number):void
		{
			value = Math.max(0.2, value);
			value = Math.min(3.0, value);
			_zoom = value;
			TweenLite.to(worldView, .2, { scaleX: value, scaleY: value, ease: Quad.easeOut } );
		}
		
		public function setZoom(value:Number):void {
			_zoom = value;
		}
		
		
		public function panToMouse():void
		{
			var layer:WorldLayerView = activeLayerView;
			var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
			
			var f:Number = 1 / zoom;
			var mx:Number = layer.x - (stage.mouseX*f);
			var my:Number = layer.y - (stage.mouseY*f);
			
			TweenLite.to(layer, .2, { x: mx, y: my, ease: Quad.easeOut } );
		}
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				default:
					break;		
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Node id. (shared with proxy)
		 */
		public function get id():String { return getMediatorName(); }
		
		/**
		 * Utility accessor.
		 */
		//private function get view():NodeView { return viewComponent as NodeView }
		
		/**
		 * Utility world mediator accessor.
		 */
		private function get world():WorldMediator { if (!_world) _world = facade.retrieveMediator(WorldMediator.NAME) as WorldMediator; return _world; }
		private function get worldView():WorldView { if (!_worldView) _worldView = world.getViewComponent() as WorldView; return _worldView; }
		private function get activeLayer():WorldLayerMediator { return facade.retrieveMediator(world.activeLayer) as WorldLayerMediator; }
		private function get activeLayerView():WorldLayerView { return activeLayer.getViewComponent() as WorldLayerView; }
		
		// Cache
		private var _world:WorldMediator;
		private var _worldView:WorldView;

	}
}
