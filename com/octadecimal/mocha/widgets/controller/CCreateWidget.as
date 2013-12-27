/*
 Command: CCreateWidget
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.controller
{
	import com.mocha.Mocha;
	import com.mocha.util.Strings;
	import com.mocha.core.controller.CUndoable;
	import com.mocha.core.model.params.Parameters;
	import com.mocha.core.model.vo.WidgetVO;
	import com.mocha.widgets.model.WidgetProxy;
	import com.mocha.widgets.view.components.WidgetView;
	import com.mocha.widgets.view.WidgetMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
    
	/**
	 * Creates a new widget. Allows for a custom model, mediator and view definition to be passed.
	 * By default, WidgetProxy, WidgetMediator and WidgetView will be used respectively. An optional
	 * generic data object may also be passed in that will be attached to the view.
	 */
	public class CCreateWidget extends CUndoable
	{	
		override public function execute(note:INotification):void 
		{
			super.execute(note);
			
			var vo:WidgetVO = note.getBody() as WidgetVO;
			
			// Validate
			if (facade.retrieveProxy(vo.name) || facade.retrieveMediator(vo.name)) { Mocha.warn(this, "A widget by that name already exists: " + vo.name); return; }
			else Mocha.debug(this, "Creating widget: " + vo.name + " (" + Strings.fromClass(vo.view) + ", " + Strings.fromClass(vo.mediator) + ")");
			
			// View
			var view:WidgetView = new vo.view(vo.name);
			if (!view) Mocha.error(this, "Failed to create view for: " + vo.name);
			
			// Mediator
			var mediator:WidgetMediator = new vo.mediator(vo.name, view) as WidgetMediator;
			if (!mediator) Mocha.error(this, "Failed to create mediator for: " + vo.name);
			
			// Register
			facade.registerMediator(mediator);
			
			// Notify
			Mocha.info(this, "Widget created: " + vo.name);
			sendNotification(Mocha.WIDGET_CREATED, vo.name);
		}
		
		/**
		 * Undo operation, deletes the wiget.
		 */
		override public function undo(note:INotification):void 
		{
			super.undo(note);
			
			// Delete widget
			sendNotification(Mocha.DELETE_WIDGET, WidgetVO(note.getBody()).name);
		}
	}
}