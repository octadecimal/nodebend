package com.octadecimal.nodebend.view.components 
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class LabelView extends SpriteView
	{
		
		private var _textfield:TextField;
		private var _textformat:TextFormat;
		
		protected function get textfield():TextField   { return _textfield; }
		protected function get textformat():TextFormat { return _textformat; }
		
		public function LabelView(text:String=null, size:Number=10, font:String="Trebuchet MS", bold:Boolean=false, color:uint=0x626262) 
		{
			// Create and initialize textfield
			_textfield = new TextField();
			_textfield.antiAliasType = AntiAliasType.ADVANCED;
			_textfield.autoSize = TextFieldAutoSize.CENTER;
			_textfield.selectable = false;
			
			// Create and initialize textformat
			_textformat = new TextFormat(font, size, color, bold);
			
			// Set default text format
			_textfield.defaultTextFormat = _textformat;
			
			// Set initial text
			setText(text);
			
			// Add textfield to display list
			addChild(_textfield); 
		}
		
		public function setText(text:String):void
		{
			if (text == null) { trace(this, "Bug at LabelView.setText(): reveived null text."); return; }	
			_textfield.text = text;
			if (_textfield.autoSize == TextFieldAutoSize.CENTER)
				_textfield.x = -_textfield.width * 0.5;
		}
		
		public function appendText(text:String):void
		{
			_textfield.appendText(text);
		}
		
		public function setFont(font:String):void
		{
			_textformat.font = font;
			setTextFormat();
		}
		
		public function setFontSize(size:Number):void
		{
			_textformat.size = size;
			setTextFormat();
		}
		
		public function setColor(color:uint):void
		{
			_textformat.color = color;
			setTextFormat();
		}
		
		public function setBold(bold:Boolean):void
		{
			_textformat.bold = bold;
			setTextFormat();
		}
		
		public function setItalic(italic:Boolean):void
		{
			_textformat.italic = italic;
			setTextFormat();
		}
		
		public function setUnderline(underline:Boolean):void
		{
			_textformat.underline = underline;
		}
		
		public function setLetterSpacing(spacing:Number):void
		{
			_textformat.letterSpacing = spacing;
			setTextFormat();
		}
		
		public function setSelectable(selectable:Boolean):void
		{
			_textfield.selectable = selectable;
		}
		
		public function useAdvancedAntiAliasing(value:Boolean):void
		{
			if (value) _textfield.antiAliasType = AntiAliasType.ADVANCED;
			else _textfield.antiAliasType = AntiAliasType.NORMAL;
		}
		
		private function setTextFormat(format:TextFormat=null):void
		{
			if (format) _textformat = format;
			_textfield.setTextFormat(_textformat);
		}
		
	}

}