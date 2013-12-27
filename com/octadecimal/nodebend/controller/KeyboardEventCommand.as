/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.nodetypes.html.Div;
	import com.octadecimal.nodebend.model.vo.KeyboardEventVO;
	import com.octadecimal.nodebend.model.vo.NodeTypeVO;
	import com.octadecimal.nodebend.Nodebend;
	import flash.events.KeyboardEvent;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class KeyboardEventCommand extends SimpleCommand {
		
		override public function execute(note:INotification):void 
		{
			var key:KeyboardEventVO = note.getBody() as KeyboardEventVO;
			
			//Nodebend.debug(this, "Key: " + key.toString());
			
			// Temporary handling
			if (key.type == KeyboardEvent.KEY_UP)
			{
				switch(key.keyCode) 
				{
					// Create <div>
					case 87: 
						if(!key.down) facade.sendNotification(Nodebend.NODE_CREATE, Div.TYPE);
						break;
					
					// Create <li>
					case 69:
						//if(!key.down) facade.sendNotification(Nodebend.CREATE_NODE, new NodeTypeVO(Li.TYPE)); 
						break;
						
					// Undo
					case 90:
						//if(key.ctrl) facade.sendNotification(Nodebend.UNDO);
						break;
				}
			}
		}
		
	}
}