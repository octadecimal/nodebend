/*
 View:   Parameters
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha.core.model.params 
{
	import com.mocha.core.view.events.ParameterEvent;
	import com.mocha.util.Collection;
	import com.mocha.util.Strings;
	import flash.events.EventDispatcher;
	
	/**
	 * Parameters in Mocha are a way of encapsulating indexed and dynamic collections of typed data
	 * and dispatches Events when values have changed.
	 */
	public class Parameters extends EventDispatcher
	{
		
		// Types
		private static const BOOLEAN:uint 		= 0;
		private static const INT:uint 			= 1;
		private static const UINT:uint 			= 2;
		private static const NUMBER:uint 		= 3;
		private static const STRING:uint 		= 4;
		private static const OBJECT:uint		= 5;
		private static const COLLECTION:uint	= 6;
		
        
		
		// Construction
		// =========================================================================================
		
		/**
		 * Constructor
		 */
		public function Parameters()
		{
			// Push value type names
			_typeNames.push("Boolean");
			_typeNames.push("Int");
			_typeNames.push("Uint");
			_typeNames.push("Number");
			_typeNames.push("String");
			_typeNames.push("Object");
			_typeNames.push("Collection");
			
			// Push value tables
			_values.push(_bools);
			_values.push(_ints);
			_values.push(_uints);
			_values.push(_numbers);
			_values.push(_strings);
			_values.push(_objects);
			_values.push(_collections);
		}
		
		/**
		 * Destructor
		 */
		public function destroy():void
		{
			// Clear value tables
			for each(var table:* in _values)
			{
				// Clear values
				for each(var value:* in table)
					value = null;
				
				// Clear table
				table = null;
			}
			
			// Clear names
			for each(var name:String in _names)
				name = null;
			
			// Clear tables
			_values = null;
			_names = null;
			_indices = null;
			_types = null;
		}
		
		
        
		// Boolean
		// =========================================================================================
		
		final public function addBoolean(name:String, value:Boolean=false):uint
		{
			_types.push(BOOLEAN);
			_names.push(name);
			_indices.push(_bools.length);
			
			return _bools.push(value) - 1;
		}
		
		final public function getBoolean(name:String):Boolean
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			return _bools[_indices[i]];
		}
		
		final public function getBooleanAt(index:uint):Boolean
		{
			return _bools[index];
		}
		
		final public function setBoolean(name:String, value:Boolean=false):void
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			_bools[_indices[i]] = value;
			changed = true;
		}
		
		final public function setBooleanAt(index:uint, value:Boolean):void
		{
			_bools[index] = value;
			changed = true;
		}
		
		
        
		// Int
		// =========================================================================================
		
		final public function addInt(name:String, value:int=0):uint
		{
			_types.push(INT);
			_names.push(name);
			_indices.push(_ints.length);
			
			return _ints.push(value) - 1;
		}
		
		final public function getInt(name:String):int
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			return _ints[_indices[i]];
		}
		
		final public function getIntAt(index:uint):int
		{
			return _ints[index];
		}
		
		final public function setInt(name:String, value:int=0):void
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			_ints[_indices[i]] = value;
			changed = true;
		}
		
		final public function setIntAt(index:uint, value:int):void
		{
			_ints[index] = value;
			changed = true;
		}
		
		
        
		// Uint
		// =========================================================================================
		
		final public function addUint(name:String, value:uint = 0):uint
		{
			_types.push(UINT);
			_names.push(name);
			_indices.push(_uints.length);
			
			return _uints.push(value) - 1;
		}
		
		final public function getUint(name:String):uint
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			return _uints[_indices[i]];
		}
		
		final public function getUintAt(index:uint):uint
		{
			return _uints[index];
		}
		
		final public function setUint(name:String, value:uint):void
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			_uints[_indices[i]] = value;
			changed = true;
		}
		
		final public function setUintAt(index:uint, value:uint):void
		{
			_uints[index] = value;
			changed = true;
		}
		
		
        
		// Number
		// =========================================================================================
		
		final public function addNumber(name:String, value:Number=0):uint
		{
			_types.push(NUMBER);
			_names.push(name);
			_indices.push(_numbers.length);
			
			return _numbers.push(value) - 1;
		}
		
		final public function getNumber(name:String):Number
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			return _numbers[_indices[i]];
		}
		
		final public function getNumberAt(index:uint):Number
		{
			return _numbers[index];
		}
		
		final public function setNumber(name:String, value:Number=0):void
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			_numbers[_indices[i]] = value;
			changed = true;
		}
		
		final public function setNumberAt(index:uint, value:Number):void
		{
			_numbers[index] = value;
			changed = true;
		}
		
		
        
		// String
		// =========================================================================================
		
		final public function addString(name:String, value:String=""):uint
		{
			_types.push(STRING);
			_names.push(name);
			_indices.push(_strings.length);
			
			return _strings.push(value) - 1;
		}
		
		final public function getString(name:String):String
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			return _strings[_indices[i]];
		}
		
		final public function getStringAt(index:uint):String
		{
			return _strings[index];
		}
		
		final public function setString(name:String, value:String=""):void
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			_strings[_indices[i]] = value;
			changed = true;
		}
		
		final public function setStringAt(index:uint, value:String):void
		{
			_strings[index] = value;
			changed = true;
		}
		
		
        
		// Object
		// =========================================================================================
		
		final public function addObject(name:String, value:Object=0):uint
		{
			_types.push(OBJECT);
			_names.push(name);
			_indices.push(_objects.length);
			
			return _objects.push(value) - 1;
		}
		
		final public function getObject(name:String):Object
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			return _objects[_indices[i]];
		}
		
		final public function getObjectAt(index:uint):Object
		{
			return _objects[index];
		}
		
		final public function setObject(name:String, value:Object):void
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			_objects[_indices[i]] = value;
			changed = true;
		}
		
		final public function setObjectAt(index:uint, value:Object):void
		{
			_objects[index] = value;
			changed = true;
		}
		
		
        
		// Collection
		// =========================================================================================
		
		final public function addCollection(name:String, value:Collection=null):uint
		{
			_types.push(COLLECTION);
			_names.push(name);
			_indices.push(_collections.length);
			
			return _collections.push(value) - 1;
		}
		
		final public function getCollection(name:String):Collection
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			return _collections[_indices[i]];
		}
		
		final public function getCollectionAt(index:uint):Collection
		{
			return _collections[index];
		}
		
		final public function setCollection(name:String, value:Collection):void
		{
			for (var i:int = _names.length - 1; i >= 0; i--)
				if (_names[i] == name) break;
			
			_collections[_indices[i]] = value;
			changed = true;
		}
		
		final public function setCollectionAt(index:uint, value:Collection):void
		{
			_collections[index] = value;
			changed = true;
		}
		
		
        
		// toString
		// =========================================================================================
		
		override public function toString():String
		{
			return ("Parameters["+name+"]");
		}
		
		public function toTable():String 
		{
			var output:String = "";
			
			var name:String, index:uint, type:uint, value:*, t:String;
			
			var nameWidth:uint = 0, typeWidth:uint=0;
			
			for (var i:uint = 0; i < _names.length; i++)
				nameWidth = Math.max(_names[i].length, nameWidth);
				
			for (i = 0; i < _typeNames.length; i++)
				typeWidth = Math.max(_typeNames[i].length, typeWidth);
			
			for (i = 0; i < _names.length; i++)
			{
				name = _names[i];
				type = _types[i];
				index = _indices[i];
				value = _values[type][index];
				
				output += Strings.tabulate([typeNames[type], name, value], [typeWidth + 3, nameWidth + 3]) + "\n";
			}
			
			return output;
		}
		
		
        
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Changed. Can be called only once per change.
		 */
		public function set changed(a:Boolean):void						{ if (a && !_c) {dispatchEvent(new ParameterEvent(ParameterEvent.CHANGED)); }_c = a; }
		public function get changed():Boolean							{ return _c; }
		private var _c:Boolean											= false;
		
		/**
		 * Values (Collection of all data vectors)
		 */
		final public function get values():Array						{ return _values; }
		private var _values:Array										= new Array(); 
		
		/**
		 * Names (Lookup table of all parameters)
		 */
		final public function get names():Vector.<String>				{ return _names; }
		private var _names:Vector.<String>								= new Vector.<String>();
		
		/**
		 * Indices (Lookup table of local data vector indices)
		 */
		final public function get indices():Vector.<uint>				{ return _indices; }
		private var _indices:Vector.<uint>								= new Vector.<uint>();
		
		/**
		 * Types (Lookup table of local data vector types)
		 */
		final public function get types():Vector.<uint>					{ return _types; }
		private var _types:Vector.<uint>								= new Vector.<uint>();
		
		/**
		 * Type names
		 */
		final public function get typeNames():Vector.<String>			{ return _typeNames; }
		private var _typeNames:Vector.<String>							= new Vector.<String>();
		
		/**
		 * Name (for debugging/convenience. optional)
		 */
		public function get name():String								{ return getString("name"); }
		
		
        
		// DATA ACCESSORS
		// =========================================================================================
		
		/**
		 * Booleans
		 */
		final public function get bools():Vector.<Boolean>				{ return _bools; }
		private var _bools:Vector.<Boolean>								= new Vector.<Boolean>();
		
		/**
		 * Integeres
		 */
		final public function get ints():Vector.<int>					{ return _ints; }
		private var _ints:Vector.<int>									= new Vector.<int>();
		
		/**
		 * Unsigned Integers
		 */
		final public function get uints():Vector.<uint>					{ return _uints; }
		private var _uints:Vector.<uint>								= new Vector.<uint>();
		
		/**
		 * Numbers
		 */
		final public function get numbers():Vector.<Number>				{ return _numbers; }
		private var _numbers:Vector.<Number>							= new Vector.<Number>();
		
		/**
		 * Strings
		 */
		final public function get strings():Vector.<String>				{ return _strings; }
		private var _strings:Vector.<String>							= new Vector.<String>();
		
		/**
		 * Objects
		 */
		final public function get objects():Vector.<Object>				{ return _objects; }
		private var _objects:Vector.<Object>							= new Vector.<Object>();
		
		/**
		 * Collections
		 */
		final public function get collections():Vector.<Collection>		{ return _collections; }
		private var _collections:Vector.<Collection>					= new Vector.<Collection>();
		
	}
}