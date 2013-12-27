/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.nodetypes.html.Div;
	import com.octadecimal.nodebend.model.vo.NodeTypeVO;
	import com.octadecimal.nodebend.model.WorldProxy;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.CameraMediator;
	import com.octadecimal.nodebend.view.components.WorldView;
	import com.octadecimal.nodebend.view.WorldMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class WorldCreateCommand extends SimpleCommand {
		
		override public function execute(note:INotification):void 
		{
			// Create view
			var view:WorldView = new WorldView();
			
			// Create proxy
			var proxy:WorldProxy = new WorldProxy();
			facade.registerProxy(proxy);
			
			// Create mediator
			var mediator:WorldMediator = new WorldMediator(view);
			facade.registerMediator(mediator);
			
			// Add view to stage
			sendNotification(Nodebend.ADD_TO_STAGE, view);
			
			// Create initial world layer
			sendNotification(Nodebend.WORLD_LAYER_CREATE);
			
			// Create camera
			var camera:CameraMediator = new CameraMediator();
			facade.registerMediator(camera);
			
			// Register node types (should go elsewhere later)
			facade.sendNotification(Nodebend.NODE_TYPE_REGISTER, new NodeTypeVO("<div>", Div));
			
			// Post-process
			Nodebend.debug(this, "World created.");
		}
		
	}
}