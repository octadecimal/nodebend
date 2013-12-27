package com.octadecimal.nodebend.model.vo 
{
	
	public class KeyboardEventVO
	{
		/**
		 * Keyboard event type.
		 */
		public var type:String;
		
		/**
		 * If the key is down (up if false).
		 */
		public var down:Boolean;
		
		/**
		 * Char code.
		 */
		public var charCode:uint;
		
		/**
		 * Key code.
		 */
		public var keyCode:uint;
		
		/**
		 * Shift key is pressed.
		 */
		public var shift:Boolean;
		
		/**
		 * Ctrl/Cmd key is pressed.
		 */
		public var ctrl:Boolean;
		
		 /**
		  * Alt pressed.
		  */
		public var alt:Boolean;
		
		/**
		 * Returns all properties of this object as a formatted string.
		 */
		public function toString():String 
		{
			return "\t type=" + type + "\t charCode=" + charCode + "\t keyCode=" + keyCode;
		}
	}

}