/*
 Event:  ParameterEvent
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.view.events 
{
	import flash.events.Event;
	
	/**
	 * Parameter event.
	 */
	public class ParameterEvent extends Event 
	{
		public static var CHANGED:String = "pChng";
		
		public var parameter:String;
		public var value:Object;
		
		public function ParameterEvent(type:String, parameter:String=null, value:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.parameter = parameter;
			this.value = value;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ParameterEvent(type, parameter, value, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ParameterEvent", "type", "parameter", "value", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}