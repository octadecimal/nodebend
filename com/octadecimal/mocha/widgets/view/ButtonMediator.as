/*
 Mediator:  ButtonMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view 
{
	import com.mocha.Mocha;
	import com.mocha.widgets.view.*;
	import com.mocha.widgets.view.components.ButtonView;
	import com.mocha.widgets.view.events.WidgetEvent;
	import com.mocha.widgets.model.params.ButtonParameters;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * ButtonMediator Mediator.
	 * ...
	 */
	public class ButtonMediator extends ContainerMediator implements IMediator 
	{
		
		
		// CONSTRUCTOR
		// ==============================================================================================
		
		/**
		 * Mediator constructor.
		 */
		public function ButtonMediator(name:String, viewComponent:ButtonView)
		{
			super(name, viewComponent);
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			view.addEventListener(WidgetEvent.CLICKED, onClick);
			view.addEventListener(WidgetEvent.SELECTED, onSelect);
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			view.removeEventListener(WidgetEvent.CLICKED, onClick);
			view.removeEventListener(WidgetEvent.SELECTED, onSelect);
		}
		
		
		
		// EVENTS
		// ==============================================================================================
		
		private function onClick(e:WidgetEvent):void 
		{
			var button:ButtonView = e.target as ButtonView;
			
			// Send button name and group
			sendNotification(Mocha.BUTTON_CLICKED, button.name, ButtonParameters(button.parameters).group);
		}
		
		private function onSelect(e:WidgetEvent):void 
		{
			var button:ButtonView = e.target as ButtonView;
			
			// Send button name and group
			sendNotification(Mocha.BUTTON_SELECTED, ButtonView(e.target).name, ButtonParameters(button.parameters).group);
		}
		
		
		
		// HANDLERS
		// ==============================================================================================
		
		private function handleButtonSelected(name:String, group:String):void
		{
			// Button clicked was in the same group as this button
			if (group == ButtonParameters(view.parameters).group)
			
				// This was not the button clicked
				if (name != getMediatorName())
					
					// Deselect this button
					ButtonParameters(view.parameters).selected = false;
		}
		
		
        
		// NOTIFICATIONS
		// ==============================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Mocha.BUTTON_SELECTED];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				
				case Mocha.BUTTON_SELECTED:
					handleButtonSelected(note.getBody() as String, note.getType());
					break;
				
				default:
					super.handleNotification(note);		
			}
		}
		
		
		
		// ACCESSORS
		// ==============================================================================================
		
		/**
		 * Utility accessor: view
		 */
		private function get view():ButtonView 			{ return viewComponent as ButtonView }

	}
}
