/*
 Medator:  CollectionMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view 
{
	import com.mocha.widgets.view.components.CollectionView;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * CollectionMediator Mediator.
	 * ...
	 */
	public class CollectionMediator extends WidgetMediator implements IMediator 
	{
		/**
		 * Mediator constructor.
		 */
		public function CollectionMediator(name:String, viewComponent:CollectionView) 
		{
			// Super
			super(name, viewComponent);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			//interests.push();
			return interests;
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
		// =========================================================================================
		
		/**
		 * Utility accessor: view
		 */
		private function get view():CollectionView { return viewComponent as CollectionView }

	}
}
