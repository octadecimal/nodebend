/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.ConnectionProxy;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.ConnectionView;
	import com.octadecimal.nodebend.view.ConnectionMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class ConnectionDeleteCommand extends SimpleCommand 
	{
		override public function execute(note:INotification):void 
		{
			// Retrieve connection id
			var id:String = note.getBody() as String;
			
			// Retrieve
			var proxy:ConnectionProxy = facade.retrieveProxy(id) as ConnectionProxy;
			var mediator:ConnectionMediator = facade.retrieveMediator(id) as ConnectionMediator;
			var view:ConnectionView = mediator.getViewComponent() as ConnectionView;
			
			// Unregister
			facade.removeProxy(id);
			facade.removeMediator(id);
			
			// Destroy
			view.destroy();
			mediator.destroy();
			proxy.destroy();
			
			// Post-process
			Nodebend.debug(this, "Connection deleted: " + id);
		}
		
	}
}