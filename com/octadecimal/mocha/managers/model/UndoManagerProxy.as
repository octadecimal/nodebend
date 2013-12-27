/*
 Proxy:  UndoManagerProxy
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.model 
{
	import com.mocha.Mocha;
	import com.mocha.core.controller.CUndoable;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * The undo manager handles all undo operations application-wide. Additional groups can be created
	 * allowing for multiple layers of undos, for example seperating selection operations and tool operations.
	 * Commands are registered in CUndoable.execute() with the notification MochaInternal.REGISTER_UNDOABLE_COMMAND,
	 * and passes in an optional string in the note type to be used as the undo group. By default,
	 * a member will belong to the group "main".
	 * 
	 * As commands are added, they are pushed to the respective undo group's stack. A pointer is used to keep track
	 * of location within history. Adding commands will increment the pointer, keeping the pointer aligned to the
	 * most recently executed command (or the highest index of the stack). Undoing commands will cause the pointer
	 * will decrease. Likewise, redoing commands will cause the pointer to increase. When a new command is registered
	 * when the pointer is NOT at the most recent command (end of the stack), all commands proceeding the pointer will
	 * be flushed and the new command will be added at the pointer location.
	 */
	public class UndoManagerProxy extends Proxy implements IProxy 
	{
		// Canonical name of the Proxy
		public static const NAME:String = "UndoManager";
		
		/**
		 * Proxy constructor.
		 */
		public function UndoManagerProxy() {
			super(NAME, data);
			
		}
		
		
		
		// API
		// =========================================================================================
		
		public function registerCommand(command:CUndoable, note:INotification, group:String="main"):void
		{
			Mocha.data(this, "Undoable command registered: " + command);
			
			// Incoming command is not created by an undo operation
			if (!_expectingUndoCommand)
			{			
				// Increment pointer
				pointer++;
				
				// Remove proceeding commands
				//if (atEnd) _history.splice(_pointer, _history.length - _pointer);
				
				// Add to history
				_history.push(command);
				
				// Save note
				_notes.push(note);
				
				// Save group
				_groups.push(group);
			}
			else Mocha.data(this, "Skipped incoming undo operation: " + command);
			
			// Not possible for a command after an undo command to be a undo operation, I hope!
			_expectingUndoCommand = false;
		}
		
		public function undo():void
		{
			if (_pointer >= 0)
			{
				// Flag next received command as an undo operation
				_expectingUndoCommand = true;
				
				// Undo history
				_history[_pointer].undo(_notes[_pointer]);
				
				// Decrement pointer
				pointer--;
			}
			else Mocha.info(this, "No commands left to undo.");
		}
		
		public function redo():void
		{
			if (_pointer < _history.length-1)
			{
				// Increment pointer
				pointer++;
				
				// Execute command
				_history[_pointer].execute(_notes[_pointer]);
			}
			else Mocha.info(this, "No commands left to redo.");
		}
		
		
		
		// UTILITY ACCESSORS
		// =========================================================================================
		
		private function get atEnd():Boolean { return (_pointer == _history.length - 1) ? true : false; }
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Maximum history
		 */
		public function set maximumHistory(a:int):void			{ _maximumHistory = a; }
		public function get maximumHistory():int				{ return _maximumHistory; }
		private var _maximumHistory:int							= 25;
		
		/**
		 * History
		 */
		public function get history():Vector.<CUndoable>		{ return _history; }
		private var _history:Vector.<CUndoable>					= new Vector.<CUndoable>();
		
		/**
		 * Notifications
		 */
		public function get notes():Vector.<INotification>		{ return _notes; }
		private var _notes:Vector.<INotification>				= new Vector.<INotification>();
		
		/**
		 * Pointer. Initialized to -1 so that it's incremented to 0 upon first command.
		 */
		public function get pointer():int						{ return _pointer; }
		public function set pointer(a:int):void					{ _pointer = a;  }
		private var _pointer:int								= -1;
		
		/**
		 * Name
		 */
		override public function getProxyName():String 			{ return UndoManagerProxy.NAME; }
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _groups:Vector.<String> = new Vector.<String>();
		
		private var _expectingUndoCommand:Boolean = false;
	}
}