/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.WorldLayerView;
	import com.octadecimal.nodebend.view.WorldLayerMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand; 
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class WorldLayerCreateCommand extends SimpleCommand 
	{
		private static var _numLayersTotal:uint = 0;
		
		override public function execute(note:INotification):void 
		{
			// Generate layer id
			var id:String = "Layer_" + _numLayersTotal;
			
			// Create view
			var view:WorldLayerView = new WorldLayerView();
			
			// Create mediator
			var mediator:WorldLayerMediator = new WorldLayerMediator(id, String(_numLayersTotal), view);
			facade.registerMediator(mediator);
			
			// Add view to world
			facade.sendNotification(Nodebend.ADD_TO_WORLD, view);
			
			// Set as active layer
			facade.sendNotification(Nodebend.SET_ACTIVE_LAYER, id);
			
			// Post-process (increment must occur after passing id to mediator)
			_numLayersTotal++;
		}
		
	}
}