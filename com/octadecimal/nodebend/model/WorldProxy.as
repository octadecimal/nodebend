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
	public class WorldProxy extends Proxy implements IProxy 
	{
		// Node types list
		private var _nodeTypes:List = new List();
		
		// Nodes list
		//public function get nodes():List { return _nodes; }
		//private var _nodes:List = new List();
		public function get nodes():Vector.<String> { return _nodes; }
		private var _nodes:Vector.<String> = new Vector.<String>();
		
		// Selections list - may be useful later so that the user may save selections,
		// rather than having one global selection singleton.
		private var _selections:List = new List();
		
		// Proxy name
		public static const NAME:String = "WorldProxy";
		
		
		/**
		 * Constructor
		 */
		public function WorldProxy(data:Object = null) 
		{
			super(NAME, data);
			Nodebend.debug(this, "Created.");
		}
		
		
		/**
		 * Registers a node type by creating an association between
		 * it's name and it's proxy class. Initiated via NodeTypeRegisterCommand.
		 * 
		 * @param	typeName	Name of node type.
		 * @param	typeProxy	Reference to type's proxy.
		 */
		public function registerNodeType(typeName:String, typeProxy:Class):void
		{
			// Add to types list
			_nodeTypes.add(typeName, typeProxy);
			
			// Debug
			Nodebend.debug(this, "Registered node type: " + typeName + " " + typeProxy);
		}
		
		
		/**
		 * Expose node type proxies.
		 */
		public function getNodeTypeClass(typeName:String):Class
		{
			return _nodeTypes.find(typeName) as Class;
		}
		
		
		/**
		 * Registers a node.
		 */
		public function registerNode(node:String):void
		{
			_nodes.push(node);
			Nodebend.debug(this, "Registered: " + node);
		}
	}
}