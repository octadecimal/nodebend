/*
 Mediator:  TextManagerMediator
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
	 * TextManagerMediator Mediator.
	 * ...
	 */
	public class TextManagerMediator extends Mediator implements IMediator 
	{
		
		// Canonical name of the Mediator
		public static const NAME:String = "TextManager";
		
		
		// CONSTRUCTOR
		// ==============================================================================================
		
		/**
		 * Mediator constructor.
		 */
		public function TextManagerMediator() {
			super(NAME, viewComponent);
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
		override public function getMediatorName():String 	{ return TextManagerMediator.NAME; }
		
		/**
		 * Utility accessor: view
		 */
		//private function get view():DisplayObject 			{ return viewComponent as DisplayObject }

	}
}
