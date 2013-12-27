/*
 Mediator:  ManagedMediator
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.view
{
	import com.mocha.core.interfaces.IJunctionMediator;
	import com.mocha.core.model.vo.BroadcastVO;
	import com.mocha.Mocha;
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.mediator.*;
	
	/**
	 * A managed mediator, in conjunction with a <code>ManagedJunctionMediator</code>, allows for
	 * easy access to standard input and output pipes by automatically providing functionality
	 * for subclasses to map external pipe messages to internal notifications and vice versa.
	 * Note that a direct descendent of <code>ManagedMediator</code> must manually create and supply
	 * a <code>ManagedJunctionMediator</code> before this mediator is registered with the facade,
	 * preferably in its constructor.
	 */
	public class ManagedMediator extends Mediator implements IMediator 
	{
		/**
		 * Mediator constructor.
		 */
		public function ManagedMediator(name:String, viewComponent:Object) {
			super(name, viewComponent);
		}	
		
		override public function onRegister():void 
		{
			super.onRegister();
			
			// Register junction
			facade.registerMediator(junction);
		}
		
		
        
		// NOTIFICATION HANDLERS
		// =========================================================================================

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void 
		{
			// Broadcast if interested notifications
			for each(var interest:BroadcastVO in junction.messageBroadcasters) 
			{
				if (interest.notification == note.getName()) 
				{
					junction.sendMessage(interest.message, note.getBody(), note.getType());
					break;
				}
			}
			
			// Default
			super.handleNotification(note);
		}
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			
			// Map notifications to be broadcast
			for each(var broadcast:BroadcastVO in junction.messageBroadcasters)
				interests.push(broadcast.notification);
			
			// Map broadcasts to be wrapped as notifications
			for each(var interest:BroadcastVO in junction.messageListeners)
				interests.push(interest.notification);
			
			return interests;
		}
		
		
		
		// MESSAGES
		// =========================================================================================
		
		/**
		 * Saves a relationship between the passed <code>message</code> and <code>notification</code>
		 * types, in that when a respective message type is receieved over a pipe, the corresponding
		 * notification will be sent internally through the core.
		 * 
		 * @param	message
		 * @param	notification
		 */
		protected function listener(message:String, notification:String=null):void
		{
			// If no notification is passed, use message.
			if (!notification) notification = message;
			
			// Save
			junction.listener(message, notification);
			
			// Debug output
			(notification==message) ? Mocha.data(this, "LSTN: m:" + message) : Mocha.data(this, "LSTN: m:" + message + " -> i:" + notification);
			
		}
		
		/**
		 * Saves a relationship between the passed <code>message</code> and <code>notification</code>
		 * types, in that when a respective notification type is receieved, the notification will be
		 * sent as a message through the output pipe.
		 * 
		 * @param	message
		 * @param	notification
		 */
		protected function broadcaster(message:String, notification:String=null):void
		{
			// If no notification is passed, use message.
			if (!notification) 
				notification = message;
			
			// Save 
			junction.broadcaster(message, notification);
			
			// Debug output
			(message==notification) ? Mocha.data(this, "BRDC: m:" + message) : Mocha.data(this, "BRDC: i:" + notification + " -> m:" + message);
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		protected var junction:IJunctionMediator;

	}
}
