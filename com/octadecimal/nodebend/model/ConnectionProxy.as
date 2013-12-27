/*
Proxy - PureMVC
*/
package com.octadecimal.nodebend.model 
{
	import com.octadecimal.nodebend.model.vo.ConnectionVO;
	import com.octadecimal.nodebend.Nodebend;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * A node connection proxy.
	 */
	public class ConnectionProxy extends Proxy implements IProxy 
	{
		
		public function ConnectionProxy(name:String, data:Object=null) {
			super(name, data);
			
		}
		
		/**
		 * Sets this object as eligable for garbage collection.
		 */
		public function destroy():void
		{
			setData(new Object());
		}
	}
}