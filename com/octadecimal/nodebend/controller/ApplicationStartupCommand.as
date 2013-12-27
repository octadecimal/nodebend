/*
Macro Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	/**
	 * A MacroCommand
	 */
	public class ApplicationStartupCommand extends MacroCommand 
	{
	
		/**
		 * Initialize the MacroCommand by adding its SubCommands.
		 * 
		 */
		override protected function initializeMacroCommand():void 
		{
			addSubCommand(ApplicationInitializeCommand);
			addSubCommand(WorldCreateCommand);
		}
		
	}
}
