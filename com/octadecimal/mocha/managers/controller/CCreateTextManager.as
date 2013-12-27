/*
 Command: CCreateTextManager
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.controller 
{
	import com.mocha.core.model.themes.Format;
	import com.mocha.managers.model.TextManagerProxy;
	import com.mocha.managers.view.TextManagerMediator;
	import com.mocha.Mocha;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CCreateTextManager extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			var proxy:TextManagerProxy = new TextManagerProxy();
			facade.registerProxy(proxy);
			facade.registerMediator(new TextManagerMediator());
			
			// Create default text format - should be deferred later elsewhere?
			proxy.registerFormat(new Format("default"));
			
			Mocha.debug(this, "Text Manager created.");
		}
		
	}
}