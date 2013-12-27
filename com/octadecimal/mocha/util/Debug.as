package com.mocha.util
{
	/**
	 * ...
	 */
	public class Debug
	{
		
		// Offset
		private static const INDENT_LENGTH:uint = 28;
		
		
		/**
		 * Data
		 */
		public static function data(origin:Object, msg:String):void
		{
			trace("2: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, "    "));
		}
		
		/**
		 * Print
		 */
		public static function print(origin:Object, msg:String):void
		{
			trace("0: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, "  > "));
		}
		
		/**
		 * Info
		 */
		public static function info(origin:Object, msg:String):void
		{
			trace("1: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, " >> "));
		}
		
		/**
		 * Warn
		 */
		public static function warn(origin:Object, msg:String):void
		{
			trace("3: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, "  ! WARNING: "));
		}
		
		/**
		 * Error
		 */
		public static function error(origin:Object, msg:String):void
		{
			trace("4: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, " !!! ERROR: "));
		}
		
		
		/**
		 * Line
		 */
		public static function line():void
		{
			trace("0: -----------------------------   ------------------------------------------------------------------");
		}
		
		/**
		 * Double line
		 */
		public static function dline():void
		{
			trace("0: =============================   ==================================================================");
		}
	}

}