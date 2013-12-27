/*
Proxy - PureMVC
*/
package com.octadecimal.nodebend.model 
{
	import com.octadecimal.nodebend.Nodebend;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * A proxy
	 */
	public class NodeProxy extends Proxy implements IProxy 
	{
		// Input nodes
		private var inputs:List = new List();
		
		// Output nodes
		private var outputs:List = new List();
		
		// Properties
		private var _properties:List = new List();
		
		
		public function NodeProxy(name:String, data:Object=null) {
			super(name, data);
			Nodebend.debug(this, "Created."); 
		}
		
	}
}