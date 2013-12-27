/*
 Mediator:  ContainerMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view 
{
	import com.mocha.Mocha;
	import com.mocha.widgets.model.WidgetProxy;
	import com.mocha.widgets.view.components.ContainerView;
	import com.mocha.widgets.view.components.WidgetView;
	import flash.display.DisplayObject;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * ContainerMediator Mediator.
	 * ...
	 */
	public class ContainerMediator extends WidgetMediator implements IMediator 
	{
		
		/**
		 * Mediator constructor.
		 */
		public function ContainerMediator(name:String, viewComponent:Object) {
			super(name, viewComponent);
		}	
		
		
		
		// API
		// =========================================================================================
		
		public function add(child:WidgetMediator):void
		{
			// Get child view
			var childView:WidgetView = child.getViewComponent() as WidgetView;
			
			// Add to view display list
			view.add(childView);
			Mocha.debug(this, "Added view: " + childView.name + " (" + getMediatorName() + ")");
			
			view.changed = true;
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
		 * Utility accessor: view
		 */
		private function get view():ContainerView { return viewComponent as ContainerView }

	}
}
