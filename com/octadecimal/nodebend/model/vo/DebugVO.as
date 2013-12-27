package com.octadecimal.nodebend.model.vo 
{
	public class DebugVO
	{
		public function get origin():String  { return _origin.toString(); }
		private var _origin:Object;
		
		public function get msg():String 	 { return _msg; }
		private var _msg:String;
		
		public function DebugVO(origin:Object, msg:String) 
		{
			_origin = origin;
			_msg = msg;
		}
	}
}