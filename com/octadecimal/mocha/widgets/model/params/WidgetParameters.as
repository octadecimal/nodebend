/*
 View:   WidgetParameters
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.widgets.model.params 
{
	import com.mocha.core.model.params.Parameters;
	import com.mocha.util.Collection;
	import com.mocha.widgets.view.components.ContainerView;
	
	/**
	 * WidgetParameters View.
	 */
	public class WidgetParameters extends Parameters
	{
		// Unique widget name
		public static const NAME:String = "name";
		
		// Local position in screen-space.
		public static const X:String = "x";
		public static const Y:String = "y";
		
		// Dimensions
		public static const WIDTH:String = "width";
		public static const HEIGHT:String = "height";
		
		// If set to true, the parent (if any) of this object will adjust it's position and
		// dimensions to fit as it sees fit.
		public static const AUTOSIZE:String = "autosize";
		
		// The color associated with this widget, typically the color it uses to draw itself.
		public static const COLOR:String = "color";
		
		// The corner radius off this object to use when drawing itself.
		public static const CORNER:String = "corner";
		
		
		/// Container params - EXPERIMENTAL
		/*
		// Growth direction; the direction at which new children will be added,
		// horizontally (to the right) or vertically (below).
		public static const DIRECTION:String = "direction";
		
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
		public static const SPACING_Y:String = "spacingY";*/
		
		
		/**
		 * Constructor
		 */
		public function WidgetParameters() 
		{
			// Super
			super();
			
			// Widget parameters
			_name			= addString(	NAME											);
			_x				= addInt(		X												);
			_y				= addInt(		Y												);
			_width			= addNumber(	WIDTH											);
			_height			= addNumber(	HEIGHT											);
			_autosize		= addBoolean(	AUTOSIZE										);
			_color			= addUint(		COLOR											);
			_corner			= addInt(		CORNER, 		8								);
			
			// Container parameters
			/*_direction 		= addString( 	 DIRECTION,		 ContainerView.VERTICAL			);
			_selectedGroup 	= addString( 	 SELECTED_GROUP, ContainerView.GROUP_DEFAULT	);
			_marginX		= addInt( 		 MARGIN_X,		 5								);
			_marginY		= addInt( 		 MARGIN_Y,		 5								);
			_spacingX		= addInt( 		 SPACING_X,		 5								);
			_spacingY		= addInt( 		 SPACING_Y,		 5								);
			_children		= addCollection( CHILDREN,		 new Collection("children")		);
			_groups			= addCollection( GROUPS,		 new Collection("groups")		);
			_currentGroup	= addCollection( CURRENT_GROUP,	 new Collection("currentGroup")	);*/
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * x (int)
		 */
		public function get x():int 						{	return getIntAt(_x);				}
		public function set x(a:int):void					{	setIntAt(_x, a);					}
		private var _x:uint;
		
		/**
		 * y (int)
		 */
		public function get y():int 						{	return getIntAt(_y);				}
		public function set y(a:int):void					{	setIntAt(_y, a);					}
		private var _y:uint;
		
		/**
		 * width (Number)
		 */
		public function get width():Number 					{	return getNumberAt(_width);			}
		public function set width(a:Number):void			{	setNumberAt(_width, a);				}
		private var _width:uint;
		
		/**
		 * height (Number)
		 */
		public function get height():Number 				{	return getNumberAt(_height);		}
		public function set height(a:Number):void			{	setNumberAt(_height, a);			}
		private var _height:uint;
		
		/**
		 * name (String)
		 */
		override public function get name():String 			{	return getStringAt(_name);			}
		public function set name(a:String):void				{	setStringAt(_name, a);				}
		private var _name:uint;
		
		/**
		 * data (Object)
		 */
		public function get data():Object 					{	return getObjectAt(_data);			}
		public function set data(a:Object):void				{	setObjectAt(_data, a);				}
		private var _data:uint;
		
		/**
		 * autosize (Boolean)
		 */
		public function get autosize():Boolean 				{	return getBooleanAt(_autosize);		}
		public function set autosize(a:Boolean):void		{	setBooleanAt(_autosize, a);			}
		private var _autosize:uint;
		
		/**
		 * color (uint)
		 */
		public function get color():uint 					{	return getUintAt(_color);			}
		public function set color(a:uint):void				{	setUintAt(_color, a);				}
		private var _color:uint;
		
		/**
		 * corner (int)
		 */
		public function get corner():int 					{	return getIntAt(_corner);			}
		public function set corner(a:int):void				{	setIntAt(_corner, a);				}
		private var _corner:uint;
		private var _spacingY:uint;
		
		
	}
	
}
