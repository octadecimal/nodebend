/*
 Event:  WidgetEvent
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 */
	public class WidgetEvent extends Event 
	{
		public static const CHANGED:String = "MChanged";
		public static const CLICKED:String = "MClicked";
		public static const SELECTED:String = "MSelected";
		
		public function WidgetEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new WidgetEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WidgetEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}