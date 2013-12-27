/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.vo.NodeTypeVO;
	import com.octadecimal.nodebend.model.WorldProxy;
	import com.octadecimal.nodebend.Nodebend;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class NodeTypeRegisterCommand extends SimpleCommand 
	{
		override public function execute(note:INotification):void 
		{
			// Retrieve references
			var vo:NodeTypeVO = note.getBody() as NodeTypeVO;
			var world:WorldProxy = facade.retrieveProxy(WorldProxy.NAME) as WorldProxy;
			
			// Register with world
			world.registerNodeType(vo.name, vo.proxy);
		}
	}
}