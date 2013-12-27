package com.octadecimal.nodebend.model.nodetypes.html 
{
	import com.octadecimal.nodebend.model.NodeProxy;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class Div extends HTMLElement implements IProxy 
	{
		/**
		 *  Node type name
		 */ public static const TYPE:String = "<div>";
		
		/**
		 *  Node type color
		 */ public static const COLOR:uint  = 0x0b7cb7;
		
		/**
		 * Constructor
		 */
		public function Div(name:String, data:Object=null) {
			super(name, data);
		}
		
	}
}