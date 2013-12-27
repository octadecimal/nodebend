/*
Simple Command - PureMVC
 */
package com.octadecimal.nodebend.controller 
{
	import com.octadecimal.nodebend.model.vo.DebugVO;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.TextBoxView;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class DebugCommand extends SimpleCommand 
	{
		private static const INDENT_LENGTH:uint = 32;
		private static const SEPERATOR:String = " ";
		
		// Temp, terrible hack. Just for now.
		private static var textbox:TextBoxView;
		private static var textbuffer:String = "";
		
		override public function execute(note:INotification):void 
		{
			// Get data
			var vo:DebugVO = note.getBody() as DebugVO;
			var output:String = "";
			
			// Append seperators for uniform output margins
			for (var i:uint = vo.origin.length; i < INDENT_LENGTH; i++)
				output += SEPERATOR;
			
			// Remove "[Object" and "]" 
			var formattedOrigin:String = "";
			formattedOrigin += vo.origin.split("[object ")[1];
			formattedOrigin = formattedOrigin.slice(0, formattedOrigin.length-1);
			output += formattedOrigin;
			
			// Append output message
			output += " > " + vo.msg;
			
			// Trace final output
			trace(output);
			
			// Notify
			facade.sendNotification(Nodebend.DEBUG_MSG, output);
			
			// Temp debug textbox
			if (!textbox && facade.retrieveMediator("WorldMediator"))
			{
				textbox = new TextBoxView(textbuffer, 12, "Consolas", false, 0xBBBBBB);
				facade.sendNotification(Nodebend.ADD_TO_STAGE, textbox);
				textbox.x = 124;
			}
			//else textbuffer += output + "\n";
			
			if (textbox) 
			{
				if(textbox.stage) textbox.y = textbox.stage.stageHeight - textbox.height - 25;
				//textbox.appendText(output + "\n"); 
				textbox.x = int(textbox.x);
				textbox.y = int(textbox.y);
			}
		}
		
	}
}