/*
 MCommand: CInitialize
 Author:   Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.controller 
{
	import com.mocha.managers.controller.CCreateColorManager;
	import com.mocha.managers.controller.CCreateTextManager;
	import com.mocha.managers.controller.CCreateUndoManager;
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	/**
	 * A MacroCommand
	 */
	public class CInitialize extends MacroCommand 
	{
	
		/**
		 * Initialize the MacroCommand by adding its SubCommands.
		 * 
		 */
		override protected function initializeMacroCommand():void 
		{
			addSubCommand(CCreateUndoManager);
			addSubCommand(CCreateColorManager);
			addSubCommand(CCreateTextManager);
		}
		
	}
}
