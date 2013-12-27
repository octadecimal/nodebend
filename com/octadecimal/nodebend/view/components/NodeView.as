package com.octadecimal.nodebend.view.components 
{
	import flash.events.Event;
	public class NodeView extends SpriteView
	{
		// Exposed
		public function get edges():ShapeView { return _edges; }
		public function get body():ShapeView  { return _body; }
		
		// Shapes
		private var _edges:ShapeView;
		private var _body:ShapeView;
		private var _caption:ShapeView;
		
		// Labels
		private var _labelType:LabelView;
		private var _labelName:LabelView;
		
		// Drawing params
		private var _width:Number = 100;
		private var _height:Number = 120;
		private var _border:Number = 5;
		private var _color:uint;
		
		
		public function NodeView(typeName:String, typeColor:uint=0x555555) 
		{
			// Save type color
			_color = typeColor;
			
			// Create shapes
			_edges =   new ShapeView(ShapeView.RECTANGLE, _width, _height, 0x262626);
			_body  =   new ShapeView(ShapeView.RECTANGLE, _width - _border * 2, _height - _border * 2, 0x131313);
			_caption = new ShapeView(ShapeView.RECTANGLE, _width - _border * 2, 28, 0x0B0B0B);
			
			// Add shapes
			addChild(_edges);
			addChild(_body);
			addChild(_caption);
			
			// Create labels
			_labelType = new LabelView(typeName, 24, "Trebuchet MS", true, typeColor);
			_labelName = new LabelView("(none)");
			
			// Add labels
			_body.addChild(_labelType);
			_caption.addChild(_labelName);
			
			// Post-process
			super();
			
			//Nodebend.debug(this, "Created."); 
		}
		
		public function setSize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			changed = true;
		}
		
		public function setBorder(size:uint):void
		{
			_border = size;
			changed = true;
		}
		
		public function setEdgesColor(color:uint):void
		{
			_edges.setColor(color);
			changed = true;
		}
		
		public function setBodyColor(color:uint):void
		{
			_body.setColor(color);
			changed = true;
		}
		
		public function setCaptionColor(color:uint):void
		{
			_caption.setColor(color);
			changed = true;
		}
		
		override public function draw(e:Event=null):void 
		{
			if (changed)
			{
				// Set sizes
				_edges.setSize(_width, _height);
				_body.setSize(_width - _border * 2, _height - _border * 2);
				_caption.setSize(_width - _border * 2, 28);
				
				// Shape positions
				_edges.x = 0; _edges.y = 0;
				_body.x = _body.y = _caption.x = _border;
				_caption.y = _height - 28 - _border;
				
				// Label positions
				_labelType.x = _labelName.x = _width * 0.5 - _border;
				_labelType.y = _height * 0.5 - 28;
				_labelName.y = 3;
				
				// Center node
				_edges.x    -=  _width * 0.5;
				_edges.y    -=  _height * 0.5;
				_body.x     -=  _width * 0.5;
				_body.y     -=  _height * 0.5;
				_caption.x  -=  _width * 0.5;
				_caption.y  -=  _height * 0.5;
				
				// Draw subcomponents
				_edges.draw();
				_body.draw();
				_caption.draw();
			}
			
			super.draw(e);
		}
		
		
		public function get color():uint { return _color; }
		
	}

}