package com.octadecimal.nodebend.model.vo 
{
	import com.octadecimal.nodebend.model.NodeProxy;
	
	public class ConnectionVO
	{
		public var outputNode:String;
		public var outputProperty:String;
		
		public var inputNode:String;
		public var inputProperty:String;
		
		public function ConnectionVO(outputNode:String=null, outputProperty:String=null, inputNode:String=null, inputProperty:String=null) 
		{
			this.outputNode = outputNode;
			this.outputProperty = outputProperty;
			
			this.inputNode = inputNode;
			this.inputProperty = inputProperty;
		}
		
	}

}