/*
 Medator:  ManagedShellMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.view
{
	import com.mocha.Mocha;
	import flash.events.Event;
	import org.puremvc.as3.multicore.interfaces.*;
	
	/**
	 * ManagedShellMediator Mediator.
	 */
	public final class MochaMediator extends ManagedMediator implements IMediator 
	{
		// Canonical name of the Mediator
		public static const NAME:String = "MochaMediator";
		
		/**
		 * Mediator constructor.
		 */
		public function MochaMediator(viewComponent:Object) 
		{
			// Mocha junction
			junction = new MochaJunctionMediator();
			
			// Map interests
			listener( Mocha.CONNECT				); 
			listener( Mocha.UNDO				);
			listener( Mocha.REDO				);
			listener( Mocha.ADD_TO_STAGE		);
			listener( Mocha.REMOVE_FROM_STAGE	);
			listener( Mocha.CREATE_WIDGET 		);
			listener( Mocha.DELETE_WIDGET 		);
			listener( Mocha.ADD_TO		 		);
			
			// Map broadcasts
			broadcaster( Mocha.WIDGET_CREATED );
			
			// Super
			super(NAME, viewComponent);
		}
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override final public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			
			return interests;
		}

		/**
		 * Notification handling.
		 */
		override final public function handleNotification(note:INotification):void 
		{
			switch (note.getName()) 
			{   
				// Default
				default:
					super.handleNotification(note);		
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessor: name
		 */
		override final public function getMediatorName():String 	{ return MochaMediator.NAME; }
		
		/**
		 * Utility accessor: view
		 */
		//public function get view():Application { return viewComponent as Application; }
	}
}
