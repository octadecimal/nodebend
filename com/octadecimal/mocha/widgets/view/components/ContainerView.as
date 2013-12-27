/*
 View:   ContainerView
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view.components 
{
	import com.mocha.core.view.events.ParameterEvent;
	import com.mocha.widgets.model.params.ContainerParameters;
	import com.mocha.widgets.model.params.WidgetParameters;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ContainerView View.
	 */
	public class ContainerView extends WidgetView
	{
		
		/**
		 * Constructor
		 */
		public function ContainerView(name:String, params:ContainerParameters=null) 
		{
			// Super
			super(name, params ? params : new ContainerParameters());
			_params = ContainerParameters(this.parameters);
			
			// Save
			this.name = name;
		}
		
		
        
		// API
		// =========================================================================================
		
		public function add(child:WidgetView, group:String=GROUP_DEFAULT):void
		{
			// Member belongs to selected group
			if (group == GROUP_ALL || group == ContainerParameters(parameters).selectedGroup)
			{
				// Add to display list
				addChild(child);
				
				// Add to current group
				_params.currentGroup.add(child.parameters);
			}
			
			// Save into children collection
			_params.children.add(child.parameters);
			
			// Save group index
			_params.groups.add(group);
			
			// Listen to child events - maybe only listen to autosizable children or if self is autosizable
			child.parameters.addEventListener(ParameterEvent.CHANGED, onChildChanged);
			
			// Flag as changed
			changed = true;
		}
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		/**
		 * Update routine.
		 */
		override public function update(change:int):void 
		{
			// Calculate known values
			calculateKnownValues();
			
			// Autosize children
			autosizeChildren();
			
			// Position children
			positionChildren();
			
			// Fit to children if has children and set to autofit
			if (_params.children.length > 0 && _params.autofit) 
				fitToChildren();
			
			super.update(change);
		}
		
		/**
		 * Update routine.
		 */
		override public function draw(g:Graphics, change:int):void 
		{
			// Clear vector buffer
			g.clear();
			
			// Use color param
			g.beginFill(_params.color);
			
			// Draw bounds rect
			//g.drawRect(0, 0, _params.width, _params.height);
			g.drawRoundRect(0, 0, _params.width, _params.height, _params.corner);
			
			// Draw
			g.endFill();
			
			g.beginFill(0xFFFFFF, 0.03)
			g.drawRoundRect(0, 0, width,  1, _params.corner);
			g.endFill();
			
			super.draw(g, change);
		}
		
		
        
		// EVENTS
		// =========================================================================================
		
		protected function onChildChanged(e:ParameterEvent):void 
		{
			// Flag as changed if set to autosizable
			if (_params.autosize) changed = true;
		}
		
		
        
		// POSITIONING & SIZING
		// =========================================================================================
		
		/**
		 * Fits this container to its children.
		 */
		private function fitToChildren():void
		{
			var w:Number = 0, h:Number = 0;
			
			// Calculate combined space of children
			for each(var child:WidgetParameters in _params.currentGroup.items)
				if (_params.direction == HORIZONTAL)  {
					w += child.width + _params.spacingX;
					h =  Math.max(h, child.height + _params.marginY * 2);
				} else  {
					w =  Math.max(w, child.width + _params.marginX * 2);
					h += child.height + _params.spacingY;
				}
			
			// Add margin
			(_params.direction == HORIZONTAL) ?  w += _params.marginX : h += _params.marginY;
			
			// Save if changed
			if (w != _params.width || h != _params.height) { _params.width = w; _params.height = h; }
			
			// Notify parent of change (EXPERIMENTAL)
			if (parent)
				if (parent is WidgetView)
					WidgetView(parent).changed = true;
		}
		
		/**
		 * Auto-positions all children of this container.
		 */
		private function positionChildren():void
		{
			for (var i:uint = 0; i < _params.currentGroup.length; i++)
				positionChildAt(_params.currentGroup.items[i], i);
		}
		
		/**
		 * Positions a child by index.
		 */
		private function positionChildAt(child:WidgetParameters, index:uint):void
		{
			var x:int = _params.marginX;
			var y:int = _params.marginY;
			
			// Ignore first
			if ( index > 0)
			{
				// Get previous child
				var previous:WidgetParameters = _params.currentGroup.items[index - 1];
				
				// Position next to previous child
				if (_params.direction == HORIZONTAL) x = previous.x + previous.width  + _params.spacingX;
				if (_params.direction == VERTICAL)	 y = previous.y + previous.height + _params.spacingY;
			}
			
			// Save if changed
			if (child.x != x || child.y != y) {
				child.x = x;
				child.y = y;
			}
		}
		
		/**
		 * Autosizes all children.
		 */
		private function autosizeChildren():void
		{
			for each(var child:WidgetParameters in _params.currentGroup.items)
			{
				// Stretch to opposite direction
				if (!child.autosize) 
				{
					if (_params.direction == HORIZONTAL)
					{
						var h:int = _params.height - _params.marginY * 2;
						if (child.height != h) child.height = h;
					}
					else
					{
						var w:int = _params.width - _params.marginX * 2;
						if (child.width != w) child.width = w;
					}
				}
				
				// Autosize child
				else autosizeChild(child);
			}
		}
		
		/**
		 * Autosizes an individual child.
		 */
		private function autosizeChild(child:WidgetParameters):void
		{
			var w:Number = _remainingWidth - _params.marginX;
			var h:Number = _remainingHeight - _params.marginY;
			
			// Subdivide
			if (_params.direction == HORIZONTAL)
			{
				w /= _numAutosizeableChildren;
				w -= _params.marginX;
			}
			else
			{
				h /= _numAutosizeableChildren;
				h -= _params.marginY;
			}
			
			// Save changed
			if (int(w) != child.width || int(h) != child.height) { child.width = w; child.height = h; }
		}
		
		/**
		 * Calculates the known values from children not to be autosized.
		 */
		private function calculateKnownValues():void
		{
			// Reset
			_remainingWidth = _params.width;
			_remainingHeight = _params.height;
			_numAutosizeableChildren = 0;
			
			// Calculate
			for each(var child:WidgetParameters in _params.currentGroup.items) 
			{
				if (!child.autosize) 
				{
					if (_params.direction == HORIZONTAL) _remainingWidth  -= child.width  + _params.spacingX;
					if (_params.direction == VERTICAL)   _remainingHeight -= child.height + _params.spacingY;
				}
				else _numAutosizeableChildren++;
			}
			
			// Remove margin
			if (_params.direction == HORIZONTAL) _remainingHeight -= _params.marginY;
			if (_params.direction == VERTICAL)   _remainingWidth  -= _params.marginX;
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		// Container parameters
		private var _params:ContainerParameters;
		
		// Number of autosizeable children, recalculated every update
		private var _numAutosizeableChildren:int = 0;
		
		// Remaining width and height, recalculated every update
		private var _remainingWidth:Number = 0, _remainingHeight:Number = 0;
		
		
		
		// CONSTANTS
		// =========================================================================================
		/**
		 * Container adds elements vertically.
		 */
		public static const VERTICAL:String = "vertical";
		
		/**
		 * Container adds elements horizontally.
		 */
		public static const HORIZONTAL:String = "horizontal";
		
		/**
		 * Default group name.
		 */
		public static const GROUP_DEFAULT:String = "default";
		
		/**
		 * Members of group "all" will be visible in all groups.
		 */
		public static const GROUP_ALL:String = "all";
	}
	
}