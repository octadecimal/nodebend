/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.ConnectionProxy;
	import com.octadecimal.nodebend.model.vo.ConnectionVO;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.ConnectionView;
	import com.octadecimal.nodebend.view.ConnectionMediator;
	import com.octadecimal.nodebend.view.NodeMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * Creates a new connection, receiving the initial output
	 * node as an argument in the note body.
	 */
	public class ConnectionCreateCommand extends SimpleCommand 
	{
		private static var _numConnectionsTotal:uint = 0;
		
		override public function execute(note:INotification):void 
		{
			// Retrieve vo
			var vo:ConnectionVO = note.getBody() as ConnectionVO;
			var outputNode:String = vo.outputNode as String;
			
			// Generate unique connection id
			var id:String = "Connection_" + _numConnectionsTotal++;
			
			// Create view
			var view:ConnectionView = new ConnectionView();
			
			// Create proxy
			var proxy:ConnectionProxy = new ConnectionProxy(id, vo);
			facade.registerProxy(proxy);
			
			// Create mediator
			var mediator:ConnectionMediator = new ConnectionMediator(id, NodeMediator(facade.retrieveMediator(outputNode)) , view);
			facade.registerMediator(mediator);
			
			// Add joint view to world
			facade.sendNotification(Nodebend.ADD_TO_WORLD_LAYER_UNDER, view, "0");
			
			// Post-process
			view.draw();
			Nodebend.debug(this, id +" created from: " + outputNode);
			
			// Send CONNECTION_STARTED notification
			facade.sendNotification(Nodebend.CONNECTION_STARTED, id);
		}
		
	}
}