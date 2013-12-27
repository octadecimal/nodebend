/*
 Command: CDeleteWidget
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.controller 
{
	import com.mocha.core.controller.CUndoable;
	import com.mocha.core.model.params.Parameters;
	import com.mocha.core.model.vo.WidgetVO;
	import com.mocha.Mocha;
	import com.mocha.widgets.model.WidgetProxy;
	import com.mocha.widgets.view.components.WidgetView;
	import com.mocha.widgets.view.WidgetMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CDeleteWidget extends CUndoable 
	{	
		override public function execute(note:INotification):void 
		{
			super.execute(note);
			
			var name:String = note.getBody() as String;
			
			// Validate
			if (!facade.retrieveProxy(name) || !facade.retrieveMediator(name)) { Mocha.warn(this, "Failed to delete widget, widget not found: " + name); return; }
			Mocha.debug(this, "Deleting widget: " + name);
			
			// Model
			var proxy:WidgetProxy = facade.retrieveProxy(name) as WidgetProxy;
			var model:Parameters = proxy.getData() as Parameters;
			
			// View
			var mediator:WidgetMediator = facade.retrieveMediator(name) as WidgetMediator;
			var view:WidgetView = mediator.getViewComponent() as WidgetView;
			
			// Unregister
			facade.removeMediator(name);
			facade.removeProxy(name);
			
			// Destroy
			view.destroy();
			model.destroy();
			
			// Notify
			Mocha.info(this, "Widget deleted: " + name);
			sendNotification(Mocha.WIDGET_DELETED, name);
		}
		
		/**
		 * Undo operation, re-creates the widget.
		 */
		override public function undo(note:INotification):void 
		{
			super.undo(note);
			
			//trace("Undoing delete: " + note.getBody());
			
			// Re-create widget
			sendNotification(Mocha.CREATE_WIDGET, note);
		}
		
	}
}