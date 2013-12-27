package com.octadecimal.nodebend.model.nodetypes.html 
{
	import com.octadecimal.nodebend.model.List;
	import com.octadecimal.nodebend.model.NodeProxy;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * HTMLElement.
	 * 
	 * Adds an HTML #id and .classes list to the base node proxy.
	 * Serves as the base class for all other html elements.
	 */
	public class HTMLElement extends NodeProxy implements IProxy 
	{
		/**
		 *  Node type name
		 */ public static const TYPE:String = "HTMLElement";
		
		/**
		 *  Node type color
		 */ public static const COLOR:uint  = 0x555555;
		 
		 // HTML #id
		 private var _htmlID:String;
		 
		 // HTML .classes
		 private var _classes:List = new List();
		
		/**
		 * Constructor
		 */
		public function HTMLElement(name:String, data:Object = null) 
		{
			super(name, data);
			
			// Copy initial html id from node name
			_htmlID = getProxyName();
		}
		
	}
	
}