/*
 View:   LabelView
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view 
{
	import com.mocha.core.model.themes.Format;
	import com.mocha.widgets.model.params.LabelParameters;
	import com.mocha.widgets.model.params.WidgetParameters;
	import com.mocha.widgets.view.components.WidgetView;
	import flash.display.Graphics;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * LabelView View.
	 */
	public class LabelView extends WidgetView
	{
		
		/**
		 * Constructor
		 */
		public function LabelView(name:String, params:LabelParameters=null) 
		{
			super(name, params ? params : new LabelParameters());
			_params = this.parameters as LabelParameters;
			
			// Field
			_field.autoSize = TextFieldAutoSize.LEFT;
			_field.selectable = false;
			addChild(_field);
		}
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		override public function update(change:int):void 
		{
			super.update(change);
			
			if (_params.width != _field.width)
				_params.width = _field.width;
			
			if (_params.height != _field.height)
				_params.height = _field.height;
				//_params.height = int(_format.size) * 2;
			
			// Set text if changed
			if(_params.text != _field.text)
				_field.text = _params.text;
		}
		
		override public function draw(g:Graphics, change:int):void 
		{
			// don't draw
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Text format
		 */
		public function set format(a:Format):void			{ _format = a; _field.defaultTextFormat = a; }
		public function get format():Format					{ return _format; }
		private var _format:Format;
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _params:LabelParameters;
		private var _field:TextField = new TextField();
	}
	
}