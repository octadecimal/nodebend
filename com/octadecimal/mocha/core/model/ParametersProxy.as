/*
 Proxy:  ParametersProxy
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.model 
{
	import com.mocha.core.model.params.Parameters;
	import com.mocha.core.view.events.ParameterEvent;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * ParametersProxy Proxy.
	 * ...
	 */
	public class ParametersProxy extends Proxy implements IProxy 
	{
		
		/**
		 * Proxy constructor.
		 */
		public function ParametersProxy(name:String, data:Parameters=null) 
		{
			// Super
			super(name, (data) ? data : new Parameters());
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			
			Parameters(data).addEventListener(ParameterEvent.CHANGED, onParameterChanged);
		}
		
		private function onParameterChanged(e:ParameterEvent):void 
		{
			
		}
	}
}