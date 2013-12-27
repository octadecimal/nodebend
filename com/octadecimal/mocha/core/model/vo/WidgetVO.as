/*
 View:   WidgetVO
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.model.vo 
{
	import com.mocha.widgets.model.WidgetProxy;
	import com.mocha.widgets.view.components.WidgetView;
	import com.mocha.widgets.view.WidgetMediator;
	
	/**
	 * WidgetVO View.
	 */
	public class WidgetVO 
	{
		
		/**
		 * Constructor
		 */
		public function WidgetVO(name:String/*, proxy:Class=null*/, view:Class=null, mediator:Class=null, data:Object=null) 
		{
			this.name = name;
			//this.proxy = proxy ? proxy : WidgetProxy;
			this.mediator = mediator ? mediator : WidgetMediator;
			this.view = view ? view : WidgetView;
			this.data = data;
		}
		
		
        
		// API
		// =========================================================================================
		
		/**
		 * Name
		 */
		public function set name(a:String):void		{ _name = a; }
		public function get name():String			{ return _name; }
		private var _name:String;
		
		/**
		 * Widget type
		 */
		public function set type(a:String):void		{ _type = a; }
		public function get type():String			{ return _type; }
		private var _type:String;
		
		/**
		 * Proxy definition
		 */
		public function set proxy(a:Class):void		{ _proxy = a; }
		public function get proxy():Class			{ return _proxy; }
		private var _proxy:Class;
		
		/**
		 * Mediator definition
		 */
		public function set mediator(a:Class):void	{ _mediator = a; }
		public function get mediator():Class		{ return _mediator; }
		private var _mediator:Class;
		
		/**
		 * View definition
		 */
		public function set view(a:Class):void		{ _view = a; }
		public function get view():Class			{ return _view; }
		private var _view:Class;
		
		/**
		 * Generic data object, typically for specific widget VOs.
		 */
		public function set data(a:Object):void		{ _data = a; }
		public function get data():Object			{ return _data; }
		private var _data:Object;
		
		
	}
	
}