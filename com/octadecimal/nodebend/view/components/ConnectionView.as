package com.octadecimal.nodebend.view.components 
{
	import com.octadecimal.nodebend.view.Colors;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ConnectionView extends SpriteView
	{
		// Starting anchor point
		private var _anchor0:Point = new Point();
		
		// Ending anchor point
		private var _anchor1:Point = new Point();
		
		// Mid point to interpolate to
		private var _anchorA:Point = new Point();
		
		// Interpolation weight
		private var _weight:Number = 0.5;
		
		
		/**
		 * Constructor.
		 */
		public function ConnectionView() 
		{
			// Empty like you.
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		/**
		 * Sets the starting point's anchor position.
		 */
		public function setAnchor0(x:Number, y:Number):void {
			_anchor0.x = x; _anchor0.y = y;
			changed = true;
		}
		
		/**
		 * Sets the end point's anchor position.
		 */
		public function setAnchor1(x:Number, y:Number):void {
			_anchor1.x = x; _anchor1.y = y;
			changed = true;
		}
		
		/**
		 * Sets both anchor positions.
		 */
		public function setAnchors(x0:Number, y0:Number, x1:Number, y1:Number):void {
			_anchor0.x = x0; _anchor0.y = y0;
			_anchor1.x = x1; _anchor1.y = y1;
			changed = true;
		}
		
		/**
		 * Sets the interpolation weight.
		 */
		public function setWeight(weight:Number):void {
			_weight = Math.min(1,Math.max(0,weight));
		}
		
		
		/**
		 * Drawing routine.
		 */
		override public function draw(e:Event=null):void 
		{
			if (changed)
			{
				// interpolate midpoint
				var distX:Number = _anchor1.x - _anchor0.x;
				var distY:Number = _anchor1.y - _anchor0.y;
				_anchorA.x = _anchor0.x + (distX * _weight);
				_anchorA.y = _anchor0.y + (distY * _weight);
				
				// project
				//_anchor0 = localToGlobal(_anchor0);
				//_anchor1 = globalToLocal(_anchor1);
				//_anchorA = globalToLocal(_anchorA);
				
				// draw
				with (graphics)
				{
					clear();
					lineStyle(3, Colors.CONNECTION, 1);
					
					// move to start anchor
					moveTo(_anchor0.x, _anchor0.y);
					
					// draw shortest path
					if (Math.abs(distX) > Math.abs(distY))
					{
						// horizontal
						lineTo(_anchorA.x, _anchor0.y);
						lineTo(_anchorA.x, _anchor1.y);
						lineTo(_anchor1.x, _anchor1.y);
					}
					else
					{
						// vertical
						lineTo(_anchor0.x, _anchorA.y);
						lineTo(_anchor1.x, _anchorA.y);
						lineTo(_anchor1.x, _anchor1.y);
					}
				}
			}
			
			super.draw(e);
		}
	}

}