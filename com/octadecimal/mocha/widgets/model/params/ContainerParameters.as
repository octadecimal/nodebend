/*
 View:   ContainerParameters
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.model.params 
{
	import com.mocha.core.model.params.Parameters;
	import com.mocha.util.Collection;
	import com.mocha.util.Collection;
	import com.mocha.widgets.model.WidgetProxy;
	import com.mocha.widgets.view.components.ContainerView;
	
	/**
	 * ContainerParameters View.
	 */
	public class ContainerParameters extends WidgetParameters
	{
		
		// Growth direction; the direction at which new children will be added,
		// horizontally (to the right) or vertically (below).
		public static const DIRECTION:String = "direction";
		
		// If a container is allowed to autofit to it's children under the right circumstances
		public static const AUTOFIT:String = "autofit";
		
		// List of all children belonging to this container.
		public static const CHILDREN:String	= "children";
		
		// String name of currently selected group, which currentGroup uses to build.
		public static const SELECTED_GROUP:String = "selectedGroup";
		
		// List of names of all children belonging to the selected group.
		public static const CURRENT_GROUP:String = "currentGroup";
		
		// Group key indices
		public static const GROUPS:String = "groups";
		
		// Margin, offsets at which children are added inside this container.
		public static const MARGIN_X:String	= "marginX";
		public static const MARGIN_Y:String	= "marginY";
		
		// Spacing, the amount of gap in between children.
		public static const SPACING_X:String = "spacingX";
		public static const SPACING_Y:String = "spacingY";
		
		
		/**
		 * Constructor
		 */
		public function ContainerParameters() 
		{
			super();
			
			_direction 		= addString( 	 DIRECTION,		 ContainerView.VERTICAL			);
			_autofit		= addBoolean(	 AUTOFIT,		 true							);	
			_selectedGroup 	= addString( 	 SELECTED_GROUP, ContainerView.GROUP_DEFAULT	);
			_marginX		= addInt( 		 MARGIN_X,		 5								);
			_marginY		= addInt( 		 MARGIN_Y,		 5								);
			_spacingX		= addInt( 		 SPACING_X,		 5								);
			_spacingY		= addInt( 		 SPACING_Y,		 5								);
			_children		= addCollection( CHILDREN,		 new Collection("children")		);
			_groups			= addCollection( GROUPS,		 new Collection("groups")		);
			_currentGroup	= addCollection( CURRENT_GROUP,	 new Collection("currentGroup")	);
		}
		
		
        
		// ACCESSORS
		// ==================================================================================================
		
		/**
		 * direction (String)
		 */
		public function get direction():String 					{	return getStringAt(_direction);			}
		public function set direction(a:String):void			{	setStringAt(_direction, a);				}
		private var _direction:uint;
		
		/**
		 * autofit (Boolean)
		 */
		public function get autofit():Boolean 					{	return getBooleanAt(_autofit);			}
		public function set autofit(a:Boolean):void				{	setBooleanAt(_autofit, a);				}
		private var _autofit:uint;
		
		/**
		 * children (Collection)
		 */
		public function get children():Collection 				{	return getCollectionAt(_children);		}
		public function set children(a:Collection):void			{	setCollectionAt(_children, a);			}
		private var _children:uint;
		
		/**
		 * selectedGroup (String)
		 */
		public function get selectedGroup():String 				{	return getStringAt(_selectedGroup);		}
		public function set selectedGroup(a:String):void		{	setStringAt(_selectedGroup, a);			}
		private var _selectedGroup:uint;
		
		/**
		 * currentGroup (Collection)
		 */
		public function get currentGroup():Collection 			{	return getCollectionAt(_currentGroup);	}
		public function set currentGroup(a:Collection):void		{	setCollectionAt(_currentGroup, a);		}
		private var _currentGroup:uint;
		
		/**
		 * groups (Collection)
		 */
		public function get groups():Collection 				{	return getCollectionAt(_groups);		}
		public function set groups(a:Collection):void			{	setCollectionAt(_groups, a);			}
		private var _groups:uint;
		
		
		/**
		 * marginX (int)
		 */
		public function get marginX():int 						{	return getIntAt(_marginX);				}
		public function set marginX(a:int):void					{	setIntAt(_marginX, a);					}
		private var _marginX:uint;
		
		/**
		 * marginY (int)
		 */
		public function get marginY():int 						{	return getIntAt(_marginY);				}
		public function set marginY(a:int):void					{	setIntAt(_marginY, a);					}
		private var _marginY:uint;
		
		/**
		 * spacingX (int)
		 */
		public function get spacingX():int 						{	return getIntAt(_spacingX);				}
		public function set spacingX(a:int):void				{	setIntAt(_spacingX, a);					}
		private var _spacingX:uint;
		
		/**
		 * spacingY (int)
		 */
		public function get spacingY():int 						{	return getIntAt(_spacingY);				}
		public function set spacingY(a:int):void				{	setIntAt(_spacingY, a);					}
		private var _spacingY:uint;
	}
	
}