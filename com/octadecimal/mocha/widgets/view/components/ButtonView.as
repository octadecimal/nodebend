/*
 View:   ButtonView
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view.components 
{
	import com.mocha.core.model.themes.Format;
	import com.mocha.Mocha;
	import com.mocha.widgets.model.params.ButtonParameters;
	import com.mocha.widgets.model.params.LabelParameters;
	import com.mocha.widgets.model.params.WidgetParameters;
	import com.mocha.widgets.view.events.WidgetEvent;
	import com.mocha.widgets.view.LabelView;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ButtonView View.
	 */
	public class ButtonView extends ContainerView
	{
		
		/**
		 * Constructor
		 */
		public function ButtonView(name:String, params:ButtonParameters=null) 
		{
			super(name, params ? params : new ButtonParameters());
			_params = this.parameters as ButtonParameters;
			
			_params.toggleable = true;
			_params.color = CLR_OUT;
		}
		
		override public function activate():void 
		{
			/*// Create label
			_label = new LabelView("Label" + name, new LabelParameters());
			_label.format = new Format("Format" +name);
			
			with (_label.parameters as LabelParameters)
			{
				text = "x";
				marginX = marginY = spacingX = spacingY = 0;
				autosize = true;
				
			}*/
			
			//add(_label);
			
			super.activate();
		}
		
		
        
		// API
		// =========================================================================================
		
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		override public function update(change:int):void 
		{
			super.update(change);
			
			// Caption
			//if (LabelParameters(_label.parameters).text != _params.caption)
				//_params.caption = LabelParameters(_label.parameters).text;
			
			// Selected
			if (_params.selected)
				switch(_params.state)
				{
					case STATE_OUT:
						_params.color = CLR_SELECTED;
						break;
					
					case STATE_OVER:
						_params.color = CLR_TOGGLE_OVER;
						break;
					
					case STATE_DOWN:
						_params.color = CLR_TOGGLE_DOWN;
						break;
				}
			
			// Not selected
			else
				switch(_params.state)
				{
					case STATE_OUT:
						_params.color = CLR_OUT;
						break;
					
					case STATE_OVER:
						_params.color = CLR_OVER;
						break;
					
					case STATE_DOWN:
						_params.color = CLR_DOWN;
						break;
				}
		}
		
		override public function draw(g:Graphics, change:int):void 
		{
			super.draw(g, change);
			
			// Draw shadow
			g.beginFill(0xFFFFFF, 0.01)
			
			//if(_params.state == STATE_DOWN && !_params.selected)
				//g.drawRoundRect(0, 0, width, height * .55, _params.corner);
			//else
				//g.drawRoundRect(0, 0, width, height * .5, _params.corner);
			
			if (_params.state == STATE_OVER || _params.selected)
				g.drawRoundRect(0, 0, width, height * .55, _params.corner);
			
			g.endFill();
		}
		
        
		// EVENTS
		// =========================================================================================
		
		override protected function onAddedToStage(e:Event):void 
		{
			super.onAddedToStage(e);
			
			// Mouse events
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			_params.state = STATE_OUT;
		}
		
		private function onOver(e:MouseEvent):void 
		{
			_params.state = STATE_OVER;
		}
		
		private function onDown(e:MouseEvent):void 
		{
			_params.state = STATE_DOWN;
		}
		
		private function onUp(e:MouseEvent):void 
		{
			if (_params.toggleable)
			{
				// Toggle
				_params.selected =  _params.selected ? false : true;
				
				// Dispatch
				if (_params.selected) 
					dispatchEvent(new WidgetEvent(WidgetEvent.SELECTED));
			}
			else 
				dispatchEvent(new WidgetEvent(WidgetEvent.CLICKED));
			
			// Unpress
			_params.state = STATE_OVER;
		}
		
		
        
		// PRIVATE
		// =========================================================================================
		
		private var _params:ButtonParameters;
		
		private var _label:LabelView;
		
		
        
		// CONSTANTS
		// =========================================================================================
		
		public static const STATE_OUT:String 		= "out";
		public static const STATE_OVER:String 		= "over";
		public static const STATE_DOWN:String		= "down";
		
		private static const CLR_OUT:uint			= 0x171717;
		private static const CLR_OVER:uint			= 0x1b1b1b;
		private static const CLR_DOWN:uint			= 0x0f0f0f;
		private static const CLR_SELECTED:uint		= 0x292929;
		private static const CLR_SHADOW:uint		= 0x101010;
		private static const CLR_TOGGLE_OVER:uint	= 0x2d2d2d;
		private static const CLR_TOGGLE_DOWN:uint	= 0x303030;
		private static const CLR_TOGGLE_BLUR:uint	= 0x222222;
		private static const CLR_CAPTION_OUT:uint 	= 0x606060;
		private static const CLR_CAPTION_OVER:uint 	= 0xffffff;
	}
	
}