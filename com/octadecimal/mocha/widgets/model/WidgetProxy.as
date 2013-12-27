/*
 Proxy:  WidgetProxy
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.model 
{
	import com.mocha.core.model.ParametersProxy;
	import com.mocha.core.model.params.Parameters;
	import com.mocha.core.model.vo.WidgetVO;
	import com.mocha.widgets.model.params.WidgetParameters;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * WidgetProxy Proxy.
	 * ...
	 */
	public class WidgetProxy extends ParametersProxy implements IProxy 
	{
		/**
		 * Proxy constructor.
		 */
		public function WidgetProxy(name:String, data:WidgetParameters=null) 
		{
			super(name, (data) ? data : new WidgetParameters());
			_params = getData() as WidgetParameters;
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Parameters
		 */
		public function get params():WidgetParameters		{ return _params; }
		private var _params:WidgetParameters;
	}
}