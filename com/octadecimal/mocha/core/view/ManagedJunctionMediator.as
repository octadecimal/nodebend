/*
 Mediator:  ManagedJunctionMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.view 
{
	import com.mocha.core.interfaces.IJunctionMediator;
	import com.mocha.core.model.vo.BroadcastVO;
	import com.mocha.Mocha;
	import com.mocha.util.Debug;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	/**
	 * A managed junction mediator allows for easy access to incoming and outgoing pipe
	 * messages by mapping external pipe messages to internal notifications and vice versa.
	 */
	public class ManagedJunctionMediator extends JunctionMediator implements IMediator, IJunctionMediator
	{
		/**
		 * Junction mediator constructor.
		 * 
		 * @param	name	Name for this junction mediator.
		 */
		public function ManagedJunctionMediator(name:String) {
			name = "[object " + name + "]";
			super(name, new Junction());
		}	
		
		
		
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 * 
		 * @return	An array of notification types to listen for.
		 */
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			
			// Map notifications to be broadcast
			for each(var interest:BroadcastVO in messageListeners)
				interests.push(interest.notification);
			
			return interests;
		}
		
		
		
		// MESSAGES
		// =========================================================================================
		
		/**
		 * Sets this object to listen for messages defined by the <code>message</code> argument;
		 * when that message is received, an internal notification defined by the <code>notification
		 * </code> will be sent.
		 * 
		 * @param	message			The message type to listen for.
		 * @param	notification	The notification type to send when message is receieved.
		 */
		public function listener(message:String, notification:String):void
		{
			messageListeners.push(new BroadcastVO(message, notification));
		}
		
		/**
		 * Sets this object to broadcast the message defined by the <code>message</code> argument;
		 * when the notification is received, a message is sent to the shell over STDOUT with the
		 * type defined by the <code>notification</code> argument.
		 * 
		 * @param	message			The message type to send.
		 * @param	notification	The trigger type of the internal notification.
		 */
		public function broadcaster(message:String, notification:String):void
		{
			messageBroadcasters.push(new BroadcastVO(message, notification));
		}
		
		/**
		 * Handles incoming pipe messages.
		 * 
		 * @param	message		Input pipe message.
		 */
		override public function handlePipeMessage(message:IPipeMessage):void
		{
			//Mocha.data(getMediatorName(), "STDIN:  " + message.getType() + ((message.getBody()) ? (" (" + message.getBody()+")") : ""));
			
			// Super
			super.handlePipeMessage(message);
			
			// Send notification for matching message interest
			for each(var interest:BroadcastVO in messageListeners) 
			{
				if (interest.message == message.getType()) 
				{
					Mocha.data(getMediatorName(), "STDIN:  " + interest.notification + ((message.getBody()) ? (" (" + message.getBody() + ")") : ""));
					sendNotification(interest.notification, message.getBody(), message.getHeader() as String);
				}
			}
		}
		
		/**
		 * Sends a message through the STDOUT pipe, with a message type and body
		 * defined by the passed arguments.
		 * 
		 * @param	type	Message type.
		 * @param	body	Message body.
		 * @param	body	Message header. (optional)
		 */
		public function sendMessage(type:String, body:Object, header:Object=null):void
		{
			Mocha.data(getMediatorName(), "STDOUT: " + type + ((body) ? (" (" + body + ")") : ""));
			junction.sendMessage(Mocha.STDOUT, new Message(type, header, body)); 
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Message interests array.
		 */
		public function get messageListeners():Array { return _messageListeners; }
		private var _messageListeners:Array  = new Array();
		//public function get messageListeners():Vector.<BroadcastVO> { return _messageListeners; }
		//private var _messageListeners:Vector.<BroadcastVO>  = new Vector.<BroadcastVO>();
		
		/**
		 * Message broadcasts Vector.<BroadcastVO>.
		 */
		public function get messageBroadcasters():Array { return _messageBroadcasters; }
		private var _messageBroadcasters:Array = new Array();
		//public function get messageBroadcasters():Vector.<BroadcastVO> { return _messageBroadcasters; }
		//private var _messageBroadcasters:Vector.<BroadcastVO> = new Vector.<BroadcastVO>();
		
		
		
		// INTERNAL
		// =========================================================================================
		
		/**
		 * Name.
		 */
		//private var _name:String;

	}
}
