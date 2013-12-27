/*
 Proxy:  TextManagerProxy
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.managers.model 
{
	import com.mocha.core.model.themes.Format;
	import com.mocha.Mocha;
	import flash.text.TextFormat;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * TextManagerProxy Proxy.
	 * ...
	 */
	public class TextManagerProxy extends Proxy implements IProxy 
	{
		// Canonical name of the Proxy
		public static const NAME:String = "TextManager";
		
		/**
		 * Proxy constructor.
		 */
		public function TextManagerProxy(data:Object = null) {
			super(NAME, data);
			
		}
		
		
		// API
		// =========================================================================================
		
		public function registerFormat(format:Format):void
		{
			Mocha.debug(this, "Registered format: " + format.name + " " + format);
			
			_formats[format.name] = format;
		}
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Text formats
		 */
		public function get formats():Object						{ return _formats; }
		private var _formats:Object									= new Object();
		
		/**
		 * Utility accessor: name
		 */
		override public function getProxyName():String 				{ return TextManagerProxy.NAME; }
		
	}
}