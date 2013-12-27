/*
 Command: CUndoable
 Author:  Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.controller 
{
	import com.mocha.core.model.MochaInternal;
	import com.mocha.core.model.vo.CommandVO;
	import com.mocha.Mocha;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CUndoable extends SimpleCommand 
	{	
		
		// CONSTRUCTOR
		// =========================================================================================
		
		/**
		 * Constructor
		 */
		public function CUndoable():void
		{
			
		}
		
		
		
		// EXECUTION
		// =========================================================================================
		
		/**
		 * Execute
		 * @param	note
		 */
		override public function execute(note:INotification):void 
		{
			// Register command with UndoManager if first execution
			if(!_executed)
				sendNotification(MochaInternal.REGISTER_UNDOABLE_COMMAND, new CommandVO(this, note));
			
			// Redo
			else
				Mocha.info(this, "Redoing.");
			
			// Save as executed
			_executed = true;
		}
		
		/**
		 * Undo
		 */
		public function undo(note:INotification):void
		{
			Mocha.info(this, "Undoing.");
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Undo group. Note that this must be modified before execute() is called.
		 */
		public function get undoGroup():String		{ return _undoGroup; }
		private var _undoGroup:String;
		
		/**
		 * Executed state (false upon first execute, true upon all others)
		 */
		public function get executed():Boolean		{ return _executed; }
		private var _executed:Boolean				= false;
	}
}