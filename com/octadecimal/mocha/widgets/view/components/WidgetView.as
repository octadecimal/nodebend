/*
 View:   WidgetView
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view.components
{
	import com.mocha.Mocha;
	import com.mocha.widgets.model.params.WidgetParameters;
	import com.mocha.core.view.events.ParameterEvent;
	import com.mocha.widgets.view.events.WidgetEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * WidgetView View.
	 */
	public class WidgetView extends Sprite
	{
		
		// CONSTRUCTION
		// =========================================================================================
		
		/**
		 * Constructor.
		 * @param	name	Widget name.
		 */
		public function WidgetView(name:String, params:WidgetParameters=null) 
		{
			// Save params
			_params = params ? params : new WidgetParameters();
			
			// Activate
			activate();
		}
		
		/**
		 * Destructor.
		 */
		public function destroy():void
		{
			// Deactivate
			deactivate();
			
			Mocha.debug(this, "Destroyed: " + name);
		}
		
		/**
		 * Activate.
		 */
		public function activate():void
		{
			// Parameter events
			_params.addEventListener(ParameterEvent.CHANGED, onParameterChanged);
			
			// View events
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		/**
		 * Deactivate.
		 */
		public function deactivate():void
		{
			// Remove events
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		/**
		 * Update routine. Called once per change, before draw(). Only updating logic should go in
		 * here, any draw calls should be deferred to draw().
		 * @param change	Amount of milliseconds passed since last update.
		 */
		public function update(change:int):void
		{
			// Constrain to parameters
			this.x = _params.x;
			this.y = _params.y;
			
			Mocha.data(this, "UPDATE: " + name);
		}
		
		/**
		 * Draw routine. Only drawing code should go in here, all logic should go be deferred
		 * to update() instead.
		 * @param g		Reference to local Graphics object. Provided for convenience.
		 */
		public function draw(g:Graphics, change:int):void
		{
		}
		
		
        
		// EVENTS
		// =========================================================================================
		
		/**
		 * Added to stage.
		 */
		protected function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * Update. Called every frame, responsible for calling update and draw if changed has occured.
		 */
		protected function onUpdate(e:Event):void 
		{
			/// Update only when changed flag has been set to true
			if (changed)
			{
				// Calculate passed time
				var time:int = getTimer();
				var change:int = time - _lastUpdateTime;
				
				// Update
				update(change);
				
				// Draw
				draw(graphics, change);
				
				// Reset change - moved this up to here to allow override?
				changed = false;
				
				// Save time
				_lastUpdateTime = time;
				
				// Dispatch change
				dispatchEvent(new WidgetEvent(WidgetEvent.CHANGED));
			}
			
			/// Unset params changed flag. Not sure I like this location/method.
			_params.changed = false;
		}
		
		protected function onParameterChanged(e:ParameterEvent):void 
		{
			// Set changed flag
			changed = true;
		}
		
		
        
		// OVERRIDES
		// =========================================================================================
		
		override public function get name():String 			{ return _params.name; 				}
		override public function set name(a:String):void  	{ super.name = _params.name = a;	}
		
		override public function get x():Number 			{ return _params.x; 				}
		override public function set x(a:Number):void  		{ super.x = _params.x = a;			}
		
		override public function get y():Number 			{ return _params.y; 				}
		override public function set y(a:Number):void  		{ super.y = _params.y = a;			}
		
		override public function get width():Number 		{ return _params.width; 			}
		override public function set width(a:Number):void  	{ _params.width = a;				}
		
		override public function get height():Number 		{ return _params.height; 			}
		override public function set height(a:Number):void  { _params.height = a;				}  
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Parameters
		 */
		public function set parameters(a:WidgetParameters):void 	{ _params = a;				}
		public function get parameters():WidgetParameters			{ return _params; 			}	
		private var _params:WidgetParameters;				
		
		/**
		 * Changed state
		 */
		public function set changed(a:Boolean):void					{ _changed = a;				}
		public function get changed():Boolean						{ return _changed;			}
		private var _changed:Boolean 								= true;
		
		
        
		// PRIVATE
		// =========================================================================================
		
		// Last update time
		private var _lastUpdateTime:int;
	}
	
}