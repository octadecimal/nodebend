package com.octadecimal.nodebend.view.components 
{
	import flash.events.Event;
	
	public class ShapeView extends SpriteView
	{
		// Shape attriutes
		private var _width:Number;
		private var _height:Number;
		private var _color:Number;
		private var _transparency:Number;
		private var _roundness:Number;
		private var _strokeWeight:Number;
		private var _strokeColor:uint;
		private var _strokeTransparency:Number;
		
		
		/**
		 * Constructor.
		 * 
		 * @param	type			Shape type, defined by ShapeView shape enumerations.
		 * @param	width			Initial shape width.
		 * @param	height			Initial shape height.
		 * @param	color			Initial shape color.
		 * @param	transparency	Initial shape transparency.
		 * @param	roundness		Initial shape roundness.
		 */
		public function ShapeView(type:String=RECTANGLE, width:Number=0, height:Number=0, color:uint=0x555555, transparency:Number=1.0, roundness:Number=0) 
		{
			_width = width;
			_height = height;
			_color = color;
			_transparency = transparency;
			_roundness  = roundness;
		}
		
		/**
		 * Sets the shape width and height.
		 * 
		 * @param	width	Desired width.
		 * @param	height	Desired height.
		 */
		public function setSize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			changed = true;
		}
		
		/**
		 * Sets the shape color.
		 * 
		 * @param	color  Desired color.
		 */
		public function setColor(color:uint):void
		{
			_color = color;
			changed = true;
		}
		
		/**
		 * Sets the shape transparency.
		 * 
		 * @param	transparency  Desired transparency.
		 */
		public function setTransparency(transparency:Number):void
		{
			_transparency = transparency;
			changed = true;
		}
		
		/**
		 * Sets the roundness if of type ShapeView.ROUND_RECTANGLE.
		 * 
		 * @param	roundness  Rectangle roundness.
		 */
		public function setRoundness(roundness:Number):void
		{
			_roundness = roundness;
			changed = true;
		}
		
		/**
		 * Sets the shape line style.
		 * @param	lineWeight			Line weight, in pixels.
		 * @param	lineTransparency	Line transparency (0-1).
		 */
		public function setLineStyle(strokeWeight:Number=0, strokeColor:Number=0x555555, strokeTransparency:Number=1):void
		{
			_strokeWeight = strokeWeight;
			_strokeColor = strokeColor;
			_strokeTransparency = strokeTransparency;
			changed = true;
		}
		
		/**
		 * Draws this shape.
		 */
		override public function draw(e:Event=null):void
		{
			if (changed)
			{
				with (graphics)
				{
					clear();
					if (_strokeWeight) graphics.lineStyle(_strokeWeight, _strokeColor, _strokeTransparency);
					beginFill(_color, _transparency);
					drawRect(0, 0, _width, _height);
				}
			}
			
			super.draw(e);
		}
		
		
		
		/**
		 *  Shape type: Oval
		 */ public static const OVAL:String = "oval";
		
		/**
		 *  Shape type: Rectangle
		 */ public static const RECTANGLE:String = "rectangle";
		
		/**
		 *  Shape type: Round Rectangle
		 */ public static const ROUND_RECTANGLE:String = "roundRectangle";
	}

}