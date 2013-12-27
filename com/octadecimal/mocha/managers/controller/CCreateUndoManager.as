/*
 Command: CCreateUndoManager
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.controller 
{
	import com.mocha.managers.model.UndoManagerProxy;
	import com.mocha.managers.view.UndoManagerMediator;
	import com.mocha.Mocha;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CCreateUndoManager extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			facade.registerProxy(new UndoManagerProxy());
			facade.registerMediator(new UndoManagerMediator());
			
			Mocha.debug(this, "Undo Manager created.");
		}
		
	}
}