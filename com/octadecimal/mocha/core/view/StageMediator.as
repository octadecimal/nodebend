/*
 Mediator:  StageMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.view 
{
	import com.mocha.Mocha;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import com.mocha.core.view.*;
	
	/**
	 * StageMediator Mediator.
	 * ...
	 */
	public class StageMediator extends Mediator implements IMediator 
	{
		// Canonical name of the Mediator
		public static const NAME:String = "StageMediator";
		
		/**
		 * Mediator constructor.
		 */
		public function StageMediator(viewComponent:Stage) {
			super(NAME, viewComponent);
			Mocha.debug(this, "Created.");
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			
			// Stage properties
			view.scaleMode = StageScaleMode.NO_SCALE;
			view.align = StageAlign.TOP_LEFT;
			
			// Add events
			view.addEventListener(Event.RESIZE, onStageResized);
		}
		
		private function onStageResized(e:Event):void 
		{
			
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// HANDLERS
		// =========================================================================================
		
		/**
		 * Add to stage.
		 */
		private function handleAddToStage(child:DisplayObject, index:int):void
		{
			(index) ? view.addChildAt(child, index) : view.addChild(child);
			Mocha.debug(this, "Added to stage: " + child.name);
		}
		
		/**
		 * Remove from stage.
		 */
		private function handleRemoveFromStage(child:DisplayObject):void
		{
			view.removeChild(child);
			Mocha.debug(this, "Removed from stage: " + child.name);
		}
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Mocha.ADD_TO_STAGE, Mocha.REMOVE_FROM_STAGE];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				
				case Mocha.ADD_TO_STAGE:
					handleAddToStage(note.getBody() as DisplayObject, int(note.getType()));
					break;
				
				case Mocha.REMOVE_FROM_STAGE:
					handleRemoveFromStage(note.getBody() as DisplayObject);
					break;
				
				default:
					break;		
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessor: name
		 */
		override public function getMediatorName():String 	{ return StageMediator.NAME; 	}
		
		/**
		 * Utility accessor: view
		 */
		private function get view():Stage 					{ return viewComponent as Stage }

	}
}
