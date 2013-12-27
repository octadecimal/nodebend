/*
 Command: CCreateColorManager
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.controller 
{
	import com.mocha.managers.model.ColorManagerProxy;
	import com.mocha.managers.view.ColorManagerMediator;
	import com.mocha.Mocha;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CCreateColorManager extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			facade.registerProxy(new ColorManagerProxy());
			facade.registerMediator(new ColorManagerMediator());
			
			Mocha.debug(this, "Color Manager created.");
		}
		
	}
}