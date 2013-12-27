package com.octadecimal.nodebend.model.vo 
{
	
	public class NodeTypeVO
	{
		public var name:String;
		public var proxy:Class;
		//public var color:uint;  <- not needed for now
		
		public function NodeTypeVO(name:String=null, proxy:Class=null/*, color:uint=0x555555*/) 
		{
			this.name = name;
			this.proxy = proxy;
			/*this.color = color;*/
		}
		
	}
}