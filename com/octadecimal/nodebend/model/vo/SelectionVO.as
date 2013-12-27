package com.octadecimal.nodebend.model.vo 
{
	
	public class SelectionVO
	{
		/**
		 * The selection this VO is created for.
		 */
		public var selection:String;
		
		/**
		 * Contents to pass to the selection.
		 */
		public var message:Object;
		
		
		public function SelectionVO(selection:String, message:Object) 
		{
			this.selection = selection;
			this.message = message;
		}
		
	}

}