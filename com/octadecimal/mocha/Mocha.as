/*
 Facade: Mocha
 Author: Dylan Heyes
 Copyright 2010, Dylan Heyes
*/
package com.mocha 
{
	import com.mocha.core.controller.*;
	import com.mocha.core.model.vo.WidgetVO;
	import com.mocha.managers.model.ColorManagerProxy;
	import com.mocha.util.Debug;
	import com.mocha.widgets.controller.*;
	import com.mocha.widgets.model.params.WidgetParameters;
	import com.mocha.widgets.model.WidgetProxy;
	import com.mocha.widgets.view.components.ContainerView;
	import com.mocha.widgets.view.components.WidgetView;
	import com.mocha.widgets.view.ContainerMediator;
	import com.mocha.widgets.view.WidgetMediator;
	import flash.display.Stage;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * Mocha ApplicationFacade. Registers commands and provides a
	 * method (startup()) to startup Mocha. Expects a reference to
	 * the Stage to be passed in the start() constructor.
	 */
	public class Mocha extends Facade implements IFacade 
	{
		// Common
		public static const NAME:String						= "Mocha";
		public static const VERSION:String					= "0.0.9";
		
		
        
		// FLOW
		// =========================================================================================
		
		/**
		 *  Debug level.
		 */ 
		public static var DEBUG_LEVEL:uint 					= 1;
		
		/**
		 * Application startup.
		 */
		public static const STARTUP:String					= "MStartup";
		
		/**
		 * Application startup.
		 */
		public static const INITIALIZE:String				= "MInitialize";
		
		
		
        
		// OPERATIONS
		// =========================================================================================
		
		/**
		 * Undos the last command.
		 */
		public static const UNDO:String						= "MUndo";
		
		/**
		 * Redos the last undone command.
		 */
		public static const REDO:String						= "MRedo";
		
		
		
        
		// WIDGET EVENTS
		// =========================================================================================
		
		/**
		 * A button has been clicked.
		 */
		public static const BUTTON_CLICKED:String			= "MButtonClicked";
		
		/**
		 * A button has been clicked.
		 */
		public static const BUTTON_SELECTED:String			= "MButtonSelected";
		
		
		
		// TEST METHODS - UNSURE IF SHOULD HAVE THESE
		// =========================================================================================
		
		public static function proxy(name:String):WidgetProxy
		{
			var p:WidgetProxy = Mocha.getInstance(NAME).retrieveProxy(name) as WidgetProxy;
			if (!p) Mocha.error("Mocha", "Proxy not found: " + name);
			return p;
		}
		
		public static function parameters(name:String):WidgetParameters
		{
			var p:WidgetParameters = view(name).parameters as WidgetParameters;
			if (!p) Mocha.error("Mocha", "Parameters not found: " + name);
			return p;
		}
		
		public static function mediator(name:String):WidgetMediator
		{
			var m:WidgetMediator = Mocha.getInstance(NAME).retrieveMediator(name) as WidgetMediator;
			if (!m) Mocha.error("Mocha", "Mediator not found: " + name);
			return m;
		}
		
		public static function view(name:String):WidgetView
		{
			var v:WidgetView = mediator(name).getViewComponent() as WidgetView;
			if(!v) Mocha.error("Mocha", "View not found: " + name);
			return v;
		}
		
		public static function color(name:String):uint
		{
			var colorManager:ColorManagerProxy = Mocha.getInstance(NAME).retrieveProxy(ColorManagerProxy.NAME) as ColorManagerProxy;
			return colorManager.getColor(name);
		}
		
		public static function widget(name:String, parent:String=null, view:Class=null, mediator:Class=null):WidgetView
		{
			Mocha.send(Mocha.CREATE_WIDGET, new WidgetVO(name, view ? view : ContainerView, mediator ? mediator : ContainerMediator));
			if(parent) Mocha.send(Mocha.ADD_TO, name, parent);
			return Mocha.view(name) as WidgetView;
		}
		
		public static function add(child:String, parent:String):void
		{
			Mocha.send(Mocha.ADD_TO, child, parent);
		}
		
		
        
		// CREATION
		// =========================================================================================
		
		/**
		 *  Creates a Widget.
		 */ 
		public static const CREATE_WIDGET:String 			= "MCreateWidget";
		
		/**
		 *  Deletes a Widget.
		 */ 
		public static const DELETE_WIDGET:String 			= "MDeleteWidget";
		 
		/**
		 *  Creates a Container widget.
		 */ 
		public static const CREATE_CONTAINER:String 		= "MCreateContainer";
		 
		/**
		 *  Creates a Panel widget.
		 */ 
		public static const CREATE_PANEL:String 			= "MCreatePanel";
		 
		/**
		 *  Creates a Button widget.
		 */ 
		public static const CREATE_BUTTON:String 			= "MCreateButton";
		 
		/**
		 *  Creates a Menu widget.
		 */ 
		public static const CREATE_MENU:String 				= "MCreateButton";
		
		
		
		
		// RESPONSES
		// =========================================================================================
		 
		/**
		 *  Widget has been created.
		 */ 
		public static const WIDGET_CREATED:String 			= "MWidgetCreated";
		 
		/**
		 *  Widget has been deleted.
		 */ 
		public static const WIDGET_DELETED:String 			= "MWidgetDeleted";
		
		
		
        
		// DISPLAY LISTS
		// =========================================================================================
		
		/**
		 *  Adds the passed DisplayObject to the Stage.
		 */ 
		public static const ADD_TO_STAGE:String 			= "MStageAdd";
		
		/**
		 *  Removes the passed DisplayObject from the Stage.
		 */ 
		public static const REMOVE_FROM_STAGE:String 		= "MStageRemove";
		
		/**
		 *  Adds the passed passed WidgetView to the passed Container.
		 */ 
		public static const ADD_TO:String 					= "MAddTo";
		
		/**
		 *  Removes the passed WidgetView from the passed Container.
		 */ 
		public static const REMOVE_FROM:String 				= "MRemoveFrom";
		
		
		
		
		// PIPES
		// =========================================================================================
		
		public static const STDOUT:String					= "stdout";
		public static const STDIN:String					= "stdin";
		public static const CONNECT:String					= "MConnect";
		
		
		
        
		// STATIC UTILITY METHODS
		// =========================================================================================
		
		public static function send(name:String, body:Object=null, type:String=null):void {
			Mocha.getInstance(NAME).sendNotification(name, body, type);
		}
		
		
		
		
		// DEBUGGUGING
		// =========================================================================================
		
		/**
		 *  Debug levels.
		 */ 
		public static const DATA:String 	= "Data";
		public static const DEBUG:String 	= "Debug";
		public static const INFO:String		= "Info";
		public static const WARN:String 	= "Warn";
		public static const ERROR:String 	= "Error";
		
		
		/**
		 * Sends a debug message of level DATA
		 */
		public static function data(source:Object, text:String):void {
			if(DEBUG_LEVEL <= 0) Debug.data(source, text);
			send(DATA, source, text);
		}
		
		/**
		 * Sends a debug message of level DEBUG
		 */
		public static function debug(source:Object, text:String):void {
			if(DEBUG_LEVEL <= 1) Debug.print(source, text);
			send(DEBUG, source, text);
		}
		
		/**
		 * Sends a debug message of level INFO
		 */
		public static function info(source:Object, text:String):void {
			if(DEBUG_LEVEL <= 2) Debug.info(source, text);
			send(INFO, source, text);INFO
		}
		
		/**
		 * Sends a debug message of level WARN
		 */
		public static function warn(source:Object, text:String):void {
			if(DEBUG_LEVEL <= 3) Debug.warn(source, text);
			send(WARN, source, text);
		}
		
		/**
		 * Sends a debug message of level ERROR
		 */
		public static function error(source:Object, text:String):void {
			if(DEBUG_LEVEL <= 4) Debug.error(source, text);
			send(ERROR, source, text);
		}
		
		
		
		
		// FACADE
		// =========================================================================================
		
		/**
		 * Constructor
		 */
		public function Mocha(key:String) {
			super(key);	
		}

        /**
         * Multiton
         */
        public static function getInstance(key:String):Mocha {
 			if (!instanceMap[key]) instanceMap[key] = new Mocha(key);
 			return Mocha(instanceMap[key]);
        }
        
        /**
         * Startup
         */  
        public static function startup(stage:Stage):void {
        	Mocha.getInstance(NAME).sendNotification( Mocha.STARTUP, stage );
        }
		
		
		
        
		// COMMANDS
		// =========================================================================================
		
		/**
		 * Register commands with the controller
		 */
		override protected function initializeController():void 
		{
			super.initializeController();
			
			registerCommand( STARTUP, 		CStartup		);
			registerCommand( INITIALIZE,	CInitialize		);
			registerCommand( UNDO,			CUndo			);
			registerCommand( REDO,			CRedo 			);
			registerCommand( CREATE_WIDGET,	CCreateWidget	);
			registerCommand( DELETE_WIDGET,	CDeleteWidget	);
			registerCommand( ADD_TO,		CAddTo			);
			
		}
	}
}