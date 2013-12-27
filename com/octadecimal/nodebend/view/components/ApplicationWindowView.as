package com.octadecimal.nodebend.view.components 
{
	import com.octadecimal.nodebend.Nodebend;
	import flash.display.Stage;
	import mx.core.WindowedApplication;
	import mx.events.FlexEvent;
	
	public class ApplicationWindowView extends WindowedApplication
	{
		public function ApplicationWindowView() 
		{
			// Set window params
			frameRate = 60;
			showStatusBar = false;
			setStyle("backgroundColor", "#0c0c0c");
			setStyle("backgroundImage", null);
			
			// Listen for flex application complete event
			addEventListener(FlexEvent.APPLICATION_COMPLETE, onApplicationComplete);
		}
		
		private function onApplicationComplete(e:FlexEvent):void 
		{
			// Remove listener
			removeEventListener(FlexEvent.APPLICATION_COMPLETE, onApplicationComplete);
			
			// Start
			var nodebend:Nodebend = Nodebend.getInstance();
			nodebend.startup(this);
		}
	}
}