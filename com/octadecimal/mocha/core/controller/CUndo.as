/*
 Command: CUndo
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.controller 
{
	import com.mocha.managers.model.UndoManagerProxy;
	import com.mocha.Mocha;
	import com.mocha.core.model.vo.WidgetVO;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CUndo extends SimpleCommand 
	{	
		
		override public function execute(note:INotification):void 
		{
			// Get undo manager
			var manager:UndoManagerProxy = facade.retrieveProxy(UndoManagerProxy.NAME) as UndoManagerProxy;
			
			// Call undo
			manager.undo();
		}
		
	}
}