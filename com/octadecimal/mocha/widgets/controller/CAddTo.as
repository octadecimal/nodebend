/*
 Command: CAddTo
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.controller 
{
	import com.mocha.Mocha;
	import com.mocha.widgets.model.ContainerProxy;
	import com.mocha.widgets.model.WidgetProxy;
	import com.mocha.widgets.view.ContainerMediator;
	import com.mocha.widgets.view.WidgetMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CAddTo extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			var childName:String = note.getBody() as String;
			var parentName:String = note.getType();
			
			// Get parent proxy
			//var parent:ContainerProxy = facade.retrieveProxy(parentName) as ContainerProxy;
			var parent:ContainerMediator = facade.retrieveMediator(parentName) as ContainerMediator;
			
			// Get child proxy
			//var child:WidgetProxy = facade.retrieveProxy(childName) as WidgetProxy;
			var child:WidgetMediator = facade.retrieveMediator(childName) as WidgetMediator;
			
			// Validate
			if (!parent || !child) Mocha.warn(this, "Encountered null reference when adding " + childName+"("+child+")" + " to " + parentName+"("+parent+")");
			
			// Add to parent proxy or mediator (?)
			parent.add(child);
		}
		
	}
}