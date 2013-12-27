/*
Proxy - PureMVC
*/
package com.octadecimal.nodebend.model 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * A proxy
	 */
	public class SelectionProxy extends Proxy implements IProxy {
		

		public function SelectionProxy(name:String, data:Object = null) {
			super(name, data);
		}
		
	}
}