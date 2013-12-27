/*
 View:   MochaInternal
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.model 
{
	
	/**
	 * Constants and values that can be used and accessed, but is seperated from the Mocha class
	 * for less clutter and gives a clear distinction between whether things like a certain notification type
	 * are used to interface Mocha internally, or is used for external Mocha interfacing.
	 */
	public class MochaInternal 
	{
		
		// OPERATIONS
		// =========================================================================================
		
		/**
		 * Registers an undable command. This is sent by a (sub)class of CUndoable upon its first execution.
		 */
		public static const REGISTER_UNDOABLE_COMMAND:String	=	"MRegisterUndoableCommand";
		
		
	}
	
}