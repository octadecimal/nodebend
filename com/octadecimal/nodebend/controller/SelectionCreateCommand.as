/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.SelectionProxy;
	import com.octadecimal.nodebend.model.vo.PositionVO;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.ShapeView;
	import com.octadecimal.nodebend.view.SelectionMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class SelectionCreateCommand extends SimpleCommand 
	{
		private static var _numSelections:uint = 0;
		
		override public function execute(note:INotification):void 
		{
			// Parse note
			var position:PositionVO = note.getBody() as PositionVO;
			
			// Generate unique name
			var name:String = "Selection_" + _numSelections;
			
			// Create selection view
			var view:ShapeView = new ShapeView();
			
			// Create selection proxy
			var proxy:SelectionProxy = new SelectionProxy(name);
			facade.registerProxy(proxy);
			
			// Create selection mediator
			var mediator:SelectionMediator = new SelectionMediator(name, position, view);
			facade.registerMediator(mediator);
			
			// Add selection view to world (dunno if this would be better in the mediator?)
			facade.sendNotification(Nodebend.ADD_TO_STAGE, view);
			
			// Post-process
			Nodebend.debug(this, name+" begun at: " + position.x + " " + position.y);
			_numSelections++;
			view.setColor(0x0);
			view.setTransparency(0.2);
			view.setLineStyle(1, 0xFFFFFF, .2);
		}
	}
}