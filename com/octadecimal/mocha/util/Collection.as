/*
 View:   Collection
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.util 
{
	import com.mocha.Mocha;
	
	/**
	 * Collection View.
	 */
	public class Collection
	{
		
		/**
		 * Constructor
		 */
		public function Collection(name:String=null, items:*=null) 
		{
			_name = name;
			_items = items ? items : new Array();
		}
		
		
        
		// API
		// =========================================================================================
		
		public function add(item:*):uint
		{
			Mocha.data("[object Collection]", "Added to collection ("+name+"): " + item);
			_items.push(item)
			return  _length++;
		}
        
		public function toString():String
		{
			return "Collection("+name+")[" + length + "] ("+_items+")";
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Length
		 */
		public function get length():uint				{ return _length; }
		private var _length:uint						= 0;
		
		/**
		 * Items
		 */
		public function set items(a:Array):void			{ _items = a; }
		public function get items():Array				{ return _items; }
		private var _items:Array						= new Array(); 
		
		/**
		 * Name
		 */
		public function set name(a:String):void	{ _name = a; }
		public function get name():String		{ return _name; }
		private var _name:String;
	}
	
}