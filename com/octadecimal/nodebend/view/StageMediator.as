/*
 Mediator - PureMVC
 */
package com.octadecimal.nodebend.view 
{
	import com.octadecimal.nodebend.model.vo.KeyboardEventVO;
	import com.octadecimal.nodebend.Nodebend;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.*;
	import com.octadecimal.nodebend.view.*;
	
	/**
	 * A Mediator
	 */
	public class StageMediator extends Mediator implements IMediator 
	{
		// Mouse position
		private var _mouseX:Number, _mouseY:Number;
		
		// Stage dimensions
		public function get width():Number { return view.stageWidth; }
		public function get height():Number { return view.stageHeight; }
		public function get halfWidth():Number { return view.stageWidth * .5; }
		public function get halfHeight():Number { return view.stageHeight * .5; }
		
		// Keyboard modifier states
		public function get altDown():Boolean { return _altDown; }
		public function get shiftDown():Boolean { return _shiftDown; }
		public function get ctrlDown():Boolean { return _ctrlDown; }
		private var _altDown:Boolean, _shiftDown:Boolean, _ctrlDown:Boolean;
		
		// Cannonical name of the Mediator
		public static const NAME:String = "StageMediator";
		
		/**
		 * StageMediator constructor.
		 */
		public function StageMediator(viewComponent:Stage) 
		{
			super(NAME, viewComponent);
			
			// Listen for stage events
			with (viewComponent)
			{
				// Mouse
				addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				
				// Keyboard
				addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				addEventListener(KeyboardEvent.KEY_UP, onKeyDown);
				
				// Other
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			
			Nodebend.debug(this, "Created.");
			
			viewComponent.nativeWindow.maximize();
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String { return StageMediator.NAME; }
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		private function onEnterFrame(e:Event):void 
		{
			
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			_mouseX = e.stageX - halfWidth;
			_mouseY = e.stageY - halfHeight;
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			// Create VO
			var vo:KeyboardEventVO = new KeyboardEventVO();
			vo.type = e.type;
			vo.down = (e.type == KeyboardEvent.KEY_DOWN) ? true : false;
			vo.charCode = e.charCode;
			vo.keyCode = e.keyCode;
			vo.shift = _shiftDown = e.shiftKey;
			vo.ctrl = _ctrlDown = e.ctrlKey || e.commandKey;
			vo.alt = _altDown = e.altKey;
			
			
			// Send notification
			sendNotification(Nodebend.KEYBOARD_EVENT, vo);
		}
		
		
		
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Nodebend.ADD_TO_STAGE, Nodebend.REMOVE_FROM_STAGE];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void 
		{
			switch (note.getName()) 
			{
				case Nodebend.ADD_TO_STAGE:
				
					Nodebend.debug(this, "Adding to stage: " + note.getBody());
					view.addChild(note.getBody() as DisplayObject);
					break;		
				
				
				case Nodebend.REMOVE_FROM_STAGE: 
				
					Nodebend.debug(this, "Removing from stage: " + note.getBody());
					view.removeChild(note.getBody() as DisplayObject);
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
		private function get view():Stage { return viewComponent as Stage }
		
		/**
		 * Exposed mouse position.
		 */
		public function get mouseX():Number { return _mouseX ; }
		public function get mouseY():Number { return _mouseY ; }

	}
}
