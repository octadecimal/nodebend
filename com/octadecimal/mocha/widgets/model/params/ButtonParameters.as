/*
 View:   ButtonParameters
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.model.params 
{
	
	/**
	 * ButtonParameters View.
	 */
	public class ButtonParameters extends ContainerParameters
	{
		// Caption text
		public static const CAPTION:String = "caption";
		
		// Current button state
		public static const STATE:String = "state";
		
		// Whether the button should be treated as a toggle button
		public static const TOGGLEABLE:String = "toggleable";
		
		// If the button is "down" when toggleable
		public static const SELECTED:String = "selected";
		
		// The (optional) group this button belongs to.
		public static const GROUP:String = "group";
		
		
		/**
		 * Constructor
		 */
		public function ButtonParameters() 
		{
			super();
			
			_caption		= addString (	CAPTION			);
			_state			= addString (	STATE			);
			_toggleable 	= addBoolean(	TOGGLEABLE		);
			_selected		= addBoolean(   SELECTED		);
			_group 			= addString(	GROUP			);
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * caption (String)
		 */
		public function get caption():String 				{	return getStringAt(_caption);	}
		public function set caption(a:String):void		{	setStringAt(_caption, a);		}
		private var _caption:uint;
		
		/**
		 * state (String)
		 */
		public function get state():String 						{	return getStringAt(_state);			}
		public function set state(a:String):void				{	setStringAt(_state, a);				}
		private var _state:uint;
		
		/**
		 * toggleable (Boolean)
		 */
		public function get toggleable():Boolean 				{	return getBooleanAt(_toggleable);	}
		public function set toggleable(a:Boolean):void			{	setBooleanAt(_toggleable, a);		}
		private var _toggleable:uint;
		
		/**
		 * selected (Boolean)
		 */
		public function get selected():Boolean 					{	return getBooleanAt(_selected);		}
		public function set selected(a:Boolean):void			{	setBooleanAt(_selected, a);			}
		private var _selected:uint;
		
		/**
		 * group (String)
		 */
		public function get group():String 						{	return getStringAt(_group);			}
		public function set group(a:String):void				{	setStringAt(_group, a);				}
		private var _group:uint;
	}
	
}