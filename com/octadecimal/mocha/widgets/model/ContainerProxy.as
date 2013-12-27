/*
 Proxy:  ContainerProxy
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.model 
{
	import com.mocha.core.model.ParametersProxy;
	import com.mocha.Mocha;
	import com.mocha.widgets.model.params.WidgetParameters;
	import com.mocha.widgets.view.components.ContainerView;
	import com.mocha.widgets.view.ContainerMediator;
	import org.puremvc.as3.multicore.interfaces.IProxy;

	/**
	 * ContainerProxy Proxy.
	 * ...
	 */
	public class ContainerProxy extends WidgetProxy implements IProxy 
	{
		
		/**
		 * Proxy constructor.
		 */
		public function ContainerProxy(name:String, data:WidgetParameters=null) 
		{
			super( name, data ? data : new WidgetParameters() );
			_params = getData() as WidgetParameters;
		}
		
		
		
		// API
		// =========================================================================================
		
		public function add(child:WidgetProxy, group:String = /*ContainerView.GROUP_DEFAULT*/"default"):void
		{
			/*Mocha.debug(this, "Adding " + child.getProxyName() + " to " + getProxyName());
			
			/// Child belongs to selected group
			if (_params.selectedGroup == group || group == ContainerView.GROUP_ALL)
			{
				// Add to display list, probably want to move this later
				mediator.addChild(child);
				
				// Add to current group
				_params.currentGroup.add(child.params);
			}
			
			/// Save
			_params.children.add(child.params);
			_params.groups.add(group);
			
			/// Flag as changed
			_params.changed = true;*/
		}
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Cache: mediator (ContainerMediator)
		 */
		private function get mediator():ContainerMediator { if (!_mediator) _mediator = facade.retrieveMediator(getProxyName()) as ContainerMediator; return _mediator; }
		private var _mediator:ContainerMediator;
		
		
		
		// PRIVATE
		// =========================================================================================
		
		// Parameters
		private var _params:WidgetParameters;
	}
}