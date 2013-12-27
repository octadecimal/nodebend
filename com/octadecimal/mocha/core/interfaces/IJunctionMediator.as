/*
 Interace: IJunctionMediator
 Author:   Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.interfaces 
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	
	/**
	 * ...
	 * @author Dylan Heyes
	 */
	public interface IJunctionMediator extends IMediator
	{
		function get messageListeners():Array;
		//function get messageListeners():Vector.<BroadcastVO>;
		function get messageBroadcasters():Array;
		//function get messageBroadcasters():Vector.<BroadcastVO>;
		function sendMessage(type:String, body:Object, header:Object = null):void;
		function broadcaster(message:String, notification:String):void;
		function listener(message:String, notification:String):void;
	}
	
}