/*
 Proxy:  ColorManagerProxy
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.model 
{
	import com.mocha.util.Collection;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * ColorManagerProxy Proxy.
	 * ...
	 */
	public class ColorManagerProxy extends Proxy implements IProxy 
	{
		// Canonical name of the Proxy
		public static const NAME:String = "ColorManager";
		
		/**
		 * Proxy constructor.
		 */
		public function ColorManagerProxy() {
			super(NAME, data);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function addColor(name:String, color:uint):void
		{
			_colors.items[name] = color;
		}
		
		public function getColor(name:String):uint
		{
			return _colors.items[name] as uint;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Colors
		 */
		public function get colors():Collection					{ return _colors; }
		private var _colors:Collection							= new Collection();
		
		/**
		 * Utility accessor: name
		 */
		override public function getProxyName():String 			{ return ColorManagerProxy.NAME; }
		
	}
}