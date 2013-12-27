/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.nodetypes.html.Div;
	import com.octadecimal.nodebend.model.vo.NodeTypeVO;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.ApplicationWindowView;
	import com.octadecimal.nodebend.view.StageMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class ApplicationInitializeCommand extends SimpleCommand 
	{
		override public function execute(note:INotification):void 
		{
			// Get window
			var window:ApplicationWindowView = note.getBody() as ApplicationWindowView;
			
			// Create stage mediator
			var stageMediator:StageMediator = new StageMediator(window.stage);
			facade.registerMediator(stageMediator);
		}
		
	}
}