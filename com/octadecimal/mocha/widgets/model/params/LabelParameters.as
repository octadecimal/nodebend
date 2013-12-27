/*
 View:   LabelParameters
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.model.params 
{
	
	/**
	 * LabelParameters View.
	 */
	public class LabelParameters extends WidgetParameters
	{
		
		// Label text
		public static const TEXT:String = "text";
		
		
		/**
		 * Constructor
		 */
		public function LabelParameters() 
		{
			
			super();
			
			_text = addString(TEXT);
		}
		
		
        
		// API
		// =========================================================================================
		
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// EVENTS
		// =========================================================================================
		
		
		
        
		// PRIVATE
		// =========================================================================================
		
		/**
		 * text (String)
		 */
		public function get text():String 				{	return getStringAt(_text);	}
		public function set text(a:String):void			{	setStringAt(_text, a);		}
		private var _text:uint;
	}
	
}