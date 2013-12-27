/*
 View:   Format
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.model.themes 
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * Format View.
	 */
	public class Format extends TextFormat
	{
		
		/**
		 * Constructor
		 */
		public function Format(name:String, size:Number=11, font:String="Arial", bold:Boolean=false, color:uint=0x626262) 
		{
			// Args
			this.name = name;
			this.size = size;
			this.font = font;
			this.bold = bold;
			this.color = color;
		}
		
		
		/**
		 * Name
		 */
		public function set name(a:String):void			{ _name = a; }
		public function get name():String				{ return _name; }
		private var _name:String;
	}
	
}