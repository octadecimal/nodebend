/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.NodeProxy;
	import com.octadecimal.nodebend.model.vo.NodeTypeVO;
	import com.octadecimal.nodebend.model.WorldProxy;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.NodeView;
	import com.octadecimal.nodebend.view.NodeMediator;
	import com.octadecimal.nodebend.view.StageMediator;
	import com.octadecimal.nodebend.view.WorldMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * Creates a node. Upon creation, the NODE_CREATED notification will be sent.
	 */
	public class NodeCreateCommand extends SimpleCommand 
	{
		private static var _numNodesTotal:uint = 0;
		
		override public function execute(note:INotification):void 
		{
			// Retrieve references
			var typeName:String = note.getBody() as String;
			var world:WorldProxy = facade.retrieveProxy(WorldProxy.NAME) as WorldProxy;
			var worldM:WorldMediator = facade.retrieveMediator(WorldMediator.NAME) as WorldMediator;
			var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
			
			// Generate unique node id
			var id:String = "Node_" + _numNodesTotal++;
			
			// Create proxy
			var typeClass:Class = world.getNodeTypeClass(typeName) as Class;
			var proxy:* = new typeClass(id);
			facade.registerProxy(proxy);
			
			// Create view
			var view:NodeView = new NodeView(typeName, typeClass.COLOR);
			
			// Create mediator
			var mediator:NodeMediator = new NodeMediator(id, view);
			facade.registerMediator(mediator);
			
			// Add view to world and spawn at mouse
			facade.sendNotification(Nodebend.ADD_TO_WORLD_LAYER, view, "0");
			view.x = worldM.mouseX; view.y = worldM.mouseY;
			
			// Register node with world
			world.registerNode(id);
			
			// Post-process
			view.draw();
			Nodebend.debug(this, "Node created: " + id);
			
			// Send NODE_CREATED notification
			facade.sendNotification(Nodebend.NODE_CREATED, id);
		}
		
	}
}