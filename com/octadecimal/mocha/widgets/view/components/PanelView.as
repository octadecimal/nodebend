/*
 View:   PanelView
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.view.components 
{
	import com.mocha.widgets.model.params.ContainerParameters;
	import com.mocha.widgets.model.params.WidgetParameters;
	
	/**
	 * PanelView View.
	 */
	public class PanelView extends ContainerView
	{
		
		/**
		 * Constructor
		 */
		public function PanelView(name:String, params:ContainerParameters=null) 
		{
			super(name, params);
			_params = this.parameters as ContainerParameters;
			
			_params.autosize = false;
			
			_params.width = 32;
			_params.height = 150;
			
			//_params.color = Math.random() * uint.MAX_VALUE;
			_params.color = 0;
		}
		
		
        
		// API
		// =========================================================================================
		
		
		
        
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// EVENTS
		// =========================================================================================
		
		
		
        
		// PRIVATE
		// =========================================================================================
		
		private var _params:WidgetParameters;
		
		
	}
	
}