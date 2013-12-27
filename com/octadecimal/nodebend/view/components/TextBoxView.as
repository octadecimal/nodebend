package com.octadecimal.nodebend.view.components 
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	public class TextBoxView extends LabelView
	{
		
		public function TextBoxView(text:String=null, size:Number=10, font:String="Trebuchet MS", bold:Boolean=false, color:uint=0x626262) 
		{
			super(text, size, font, bold, color);
			
			// Initialize textfield
			with (textfield) {
				multiline = true;
				autoSize = TextFieldAutoSize.LEFT;
				//embedFonts = true;
			}
		}
		
		public function setEditable(value:Boolean):void {
			if (value == true) {
				textfield.selectable = true;
				textfield.type = TextFieldType.INPUT;
			} else {
				textfield.selectable = false;
				textfield.type = TextFieldType.DYNAMIC;
			}
		}
		
	}

}