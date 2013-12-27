/*
 Command: CStartup
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.controller 
{
	import com.mocha.core.view.MochaMediator;
	import com.mocha.core.view.StageMediator;
	import com.mocha.Mocha;
	import com.mocha.util.Debug;
	import flash.display.Stage;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CStartup extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			Debug.dline();
			Debug.info(this, "Mocha " + Mocha.VERSION + " starting...");
			Debug.info(this, "Copyright (c) 2010 Dylan Heyes. All rights reserved.");
			Debug.line();
			
			// Stage Mediator - maybe consolidate this into MochaMediator later
			facade.registerMediator(new StageMediator(note.getBody() as Stage));
			
			// Mocha Mediator
			facade.registerMediator(new MochaMediator(note.getBody() as Stage));
			
			// Initialize
			sendNotification(Mocha.INITIALIZE);
			
			Debug.line();
			Debug.info(this, "Mocha started.");
		}
		
	}
}