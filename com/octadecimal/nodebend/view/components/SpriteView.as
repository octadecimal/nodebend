package com.octadecimal.nodebend.view.components 
{
	import com.octadecimal.nodebend.Nodebend;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SpriteView extends Sprite
	{
		/**
		 * Changed flag
		 */
		public function set changed(a:Boolean):void	{ 
			_changed = a;
			if (stage) stage.addEventListener(Event.ENTER_FRAME, draw);
		}
		
		public function get changed():Boolean		{ return _changed; }
		private var _changed:Boolean = true;
		
		/**
		 * Constructor.
		 */
		public function SpriteView() 
		{
			//ApplicationWindow.stage.addEventListener(Event.ENTER_FRAME, draw);
			//Nodebend.debug(this, "Created.");
		}
		
		/**
		 * Sets this object as eligable for garbage collection.
		 */
		public function destroy():void
		{
		}
		
		/**
		 * Draws this view and sets the changed flag to false.
		 * 
		 * @param	e  Optional event.
		 */
		public function draw(e:Event=null):void
		{ 
			//if(_changed) trace("-> Draw: "+this+"::"+name);
			//if (_changed && stage) stage.removeEventListener(Event.ENTER_FRAME, draw);
			_changed = false;
		}
	}
}