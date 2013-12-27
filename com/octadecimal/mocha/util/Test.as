/*
 View:   Test
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.util 
{
	import com.mocha.Mocha;
	import com.mocha.widgets.model.params.ButtonParameters;
	import com.mocha.widgets.view.ButtonMediator;
	import com.mocha.widgets.view.CollectionMediator;
	import com.mocha.widgets.view.components.ButtonView;
	import com.mocha.widgets.view.components.CollectionView;
	import com.mocha.widgets.view.components.ContainerView;
	import com.mocha.widgets.view.components.WidgetView;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * Test View.
	 */
	public class Test extends Sprite
	{
		/**
		 * Constructor
		 */
		public function Test() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
        
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		private function create():void
		{
			Mocha.startup(stage);
			
			var radioGroup:WidgetView = Mocha.widget("RadioGroup", null, WidgetView);
			addChild(radioGroup);
			
			radioGroup.parameters.width = 200;
			radioGroup.parameters.height = 200;
			radioGroup.parameters.color = 0x111111;
			
			for (var i:uint = 0; i < 5; i++)
				createButton(i);
		}
		
		private function onUpdate(e:Event):void 
		{
			
		}
		
		
        
		// TEST CASES
		// =========================================================================================
		
		private function createButton(name:int):ButtonView
		{
			var button:ButtonView = Mocha.widget("Button"+name, "RadioGroup", ButtonView, ButtonMediator) as ButtonView;
			
			with (button.parameters as ButtonParameters)
			{
				x = 100;
				y = 100;
				width = 100;
				height = 30;
				group = "RadioGroup"
			}
			
			//addChild(button);
			
			return button;
		}
		
		
        
		// EVENTS
		// =========================================================================================
		
		private function onAddedToStage(e:Event):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			create();
			
			addEventListener(Event.ENTER_FRAME, onUpdate);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private var _parent:ContainerView;
	}
	
}