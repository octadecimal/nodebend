/*
 Mediator:  ColorManagerMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.view 
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import com.mocha.managers.view.*;
	
	/**
	 * ColorManagerMediator Mediator.
	 * ...
	 */
	public class ColorManagerMediator extends Mediator implements IMediator 
	{
		
		// Canonical name of the Mediator
		public static const NAME:String = "ColorManager";
		
		
		// CONSTRUCTOR
		// ==============================================================================================
		
		/**
		 * Mediator constructor.
		 */
		public function ColorManagerMediator() {
			super(NAME);
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
		}
		
		
		
		// VIEW MANIPULATION
		// ==============================================================================================
		
		
		
		
		// EVENTS
		// ==============================================================================================
		
		
		
        
		// HANDLERS
		// ==============================================================================================
		
		
		
        
		// NOTIFICATIONS
		// ==============================================================================================
		
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
					super.handleNotification(note);		
			}
		}
		
		
		
		
		// ACCESSORS
		// ==============================================================================================
		
		/**
		 * Utility accessor: name
		 */
		override public function getMediatorName():String 	{ return ColorManagerMediator.NAME; }

	}
}
