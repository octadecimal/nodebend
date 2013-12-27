/*
 Mediator:  UndoManagerMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.view 
{
	import com.mocha.core.controller.CUndoable;
	import com.mocha.core.model.MochaInternal;
	import com.mocha.core.model.vo.CommandVO;
	import com.mocha.managers.model.UndoManagerProxy;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import com.mocha.managers.view.*;
	
	/**
	 * UndoManagerMediator Mediator.
	 * ...
	 */
	public class UndoManagerMediator extends Mediator implements IMediator 
	{
		// Canonical name of the Mediator
		public static const NAME:String = "UndoManager";
		
		/**
		 * Mediator constructor.
		 */
		public function UndoManagerMediator() {
			super(NAME);
		}	
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// HANDLERS
		// =========================================================================================
		
		private function handleRegisterUndoableCommand(command:CommandVO, group:String=null):void
		{
			proxy.registerCommand(command.command, command.note, group);
		}
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [MochaInternal.REGISTER_UNDOABLE_COMMAND];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				
				case MochaInternal.REGISTER_UNDOABLE_COMMAND:
					handleRegisterUndoableCommand(note.getBody() as CommandVO, note.getType());
					break;
				
				default:
					break;		
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Cache: proxy (UndoManagerProxy)
		 */
		private function get proxy():UndoManagerProxy { if (!_proxy) _proxy = facade.retrieveProxy(UndoManagerProxy.NAME) as UndoManagerProxy; return _proxy; }
		private var _proxy:UndoManagerProxy;
		
		/**
		 * Utility accessor: name
		 */
		override public function getMediatorName():String 	{ return UndoManagerMediator.NAME; }

	}
}
