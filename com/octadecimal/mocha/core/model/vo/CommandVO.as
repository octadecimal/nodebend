/*
 View:   CommandVO
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.model.vo 
{
	import com.mocha.core.controller.CUndoable;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * CommandVO View.
	 */
	public class CommandVO 
	{
		
		/**
		 * Constructor
		 */
		public function CommandVO(command:CUndoable, note:INotification) 
		{
			this.command = command;
			this.note = note;
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Command
		 */
		public function set command(a:CUndoable):void	{ _command = a; }
		public function get command():CUndoable		{ return _command; }
		private var _command:CUndoable;
		
		/**
		 * Notification
		 */
		public function set note(a:INotification):void	{ _note = a; }
		public function get note():INotification		{ return _note; }
		private var _note:INotification;
	}
	
}