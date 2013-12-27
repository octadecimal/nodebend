/*
 Medator:  ManagedShellJunctionMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.view 
{
	import com.mocha.Mocha;
	import com.mocha.util.Debug;
	import com.mocha.util.Strings;
	import com.mocha.core.interfaces.IJunctionMediator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.*;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.*;
	
	/**
	 * ManagedShellJunctionMediator Mediator.
	 * ...
	 */
	public final class MochaJunctionMediator extends ManagedJunctionMediator implements IMediator, IJunctionMediator
	{
		// Canonical name of the Mediator
		public static const NAME:String = "MochaMediatorJ";
		
		/**
		 * Mediator constructor.
		 */
		public function MochaJunctionMediator() 
		{
			// Super
			super(NAME);
		}
		
		/**
		 * Register pipes.
		 */
		override final public function onRegister():void 
		{
			super.onRegister();
			
			// Pipe: Standard Out
			junction.registerPipe(Mocha.STDOUT, Junction.OUTPUT, new TeeSplit());
			
			// Pipe: Standard In
			junction.registerPipe(Mocha.STDIN, Junction.INPUT, new TeeMerge());
			
			// Listener: Standard In
			junction.addPipeListener(Mocha.STDIN, this, handlePipeMessage);
		}
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		/**
		 * Creates and connects a pipe from Mocha to the module.
		 */
		private function connectMochaToModule(module:IPipeAware):void
		{
			// Create pipe
			var mochaToModule:Pipe = new Pipe();
			
			// Accept input pipe
			module.acceptInputPipe(Mocha.STDIN, mochaToModule);
			
			// Get STDOUT pipe
			var mochaOut:IPipeFitting = junction.retrievePipe(Mocha.STDOUT) as IPipeFitting;
			
			// Connect STDOUT to Mocha
			mochaOut.connect(mochaToModule);
			
			// Debug
			Mocha.data(getMediatorName(), "Pipe:  Mocha -> " + Strings.fromObject(module) + " ("+ Strings.fromObject(mochaOut)+")");
		}
		
		/**
		 * Creates and connects a pipe from the module to Mocha.
		 */
		private function connectModuleToMocha(module:IPipeAware):void
		{
			// Create module output pipe
			var moduleToMocha:Pipe = new Pipe();
			
			// Accept output pipe
			module.acceptOutputPipe(Mocha.STDOUT, moduleToMocha);
			
			// Get mocha input pipe
			var mochaIn:TeeMerge = junction.retrievePipe(Mocha.STDIN) as TeeMerge;
			
			// Connect fitting to mocha input pipe
			mochaIn.connectInput(moduleToMocha);
			
			// Debug
			Mocha.data(getMediatorName(), "Pipe:  Mocha <- " + Strings.fromObject(module) + " ("+ Strings.fromObject(mochaIn) +")");
		}
		
		
		
		// HANDLERS
		// =========================================================================================
		
		override final public function handlePipeMessage(message:IPipeMessage):void 
		{
			super.handlePipeMessage(message);
			
			// Bounce all data
			junction.sendMessage(Mocha.STDOUT, message);
		}
		
		private function handleConnect(module:IPipeAware):void
		{
			Mocha.data(getMediatorName(), "Connecting: " + Strings.fromObject(module));
			
			// Mocha->Module
			connectMochaToModule(module);
			
			// Module->Mocha
			connectModuleToMocha(module);
			
			Mocha.debug(getMediatorName(), "Connected: " + Strings.fromObject(module));
		}
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification handling.
		 */
		override final public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				
				case Mocha.CONNECT:
					handleConnect(note.getBody() as IPipeAware);
					break;
				
				default:
					super.handleNotification(note);		
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessor: name
		 */
		override final public function getMediatorName():String 	{ return MochaJunctionMediator.NAME; }
	}
}
