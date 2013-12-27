package com.octadecimal.nodebend 
{
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.facade.*;
	import com.octadecimal.nodebend.controller.*;
	import com.octadecimal.nodebend.model.*;
	import com.octadecimal.nodebend.model.vo.*;
	import com.octadecimal.nodebend.view.*;
	import com.octadecimal.nodebend.view.components.*;
	
	
	public class Nodebend extends Facade implements IFacade 
	{
		/**
		 *  Application start
		 */ public static const STARTUP:String = "startup";
		
		/**
		 *  New debug message to be handled
		 */ public static const DEBUG:String = "debug";
		
		/**
		 *  New handled debug message output
		 */ public static const DEBUG_MSG:String = "debugMsg";
		
		/**
		 *  New keyboard activity
		 */ public static const KEYBOARD_EVENT:String = "keyboardEvent";
		
		/**
		 *  Notification to tell stage to add a child
		 */ public static const ADD_TO_STAGE:String = "addToStage";
		
		/**
		 *  Notification to tell stage to remove a child
		 */ public static const REMOVE_FROM_STAGE:String = "removeFromStage";
		
		/**
		 *  Notification to tell world to add a child
		 */ public static const ADD_TO_WORLD:String = "addToWorld";
		
		/**
		 *  Notification to tell world to add a child at the lowest index
		 */ public static const ADD_TO_WORLD_UNDER:String = "addToWorldUnder";
		
		/**
		 *  Notification to tell world to remove a child
		 */ public static const REMOVE_FROM_WORLD:String = "removeFromWorld";
		
		/**
		 *  Notification to tell world to add a child
		 */ public static const WORLD_LAYER_CREATE:String = "worldLayerCreate";
		
		/**
		 *  Notification to tell world to add a child
		 */ public static const ADD_TO_WORLD_LAYER:String = "addToWorldLayer";
		
		/**
		 *  Notification to tell world to add a child
		 */ public static const ADD_TO_WORLD_LAYER_UNDER:String = "addToWorldLayerUnder";
		
		/**
		 *  Notification to tell world layer to remove child
		 */ public static const REMOVE_FROM_WORLD_LAYER:String = "removeFromWorldLayer";
		
		/**
		 *  Notification to tell world to set the passed layer's id as active
		 */ public static const SET_ACTIVE_LAYER:String = "setActiveLayer";
		
		/**
		 *  Requests a node type to be registered
		 */ public static const NODE_TYPE_REGISTER:String = "nodeTypeRegister";
		
		/**
		 *  Requests a node to be created
		 */ public static const NODE_CREATE:String = "nodeCreate";
		
		/**
		 *  Requests a node to be created
		 */ public static const NODE_CREATED:String = "nodeCreated";
		
		/**
		 *  Sent when the user has finished creating a new connection.
		 */ public static const CONNECTION_CREATE:String = "connectionCreate";
		
		/**
		 *  Sent when the user has begun creating a new connection.
		 */ public static const CONNECTION_STARTED:String = "connectionStarted";
		
		/**
		 *  Sent when the user has finished creating a new connection.
		 */ public static const CONNECTION_FINISHED:String = "connectionFinished";
		
		/**
		 *  Sent when the user has effectively canceled a connection.
		 */ public static const CONNECTION_CANCEL:String = "connectionCancel";
		
		/**
		 *  Sent to delete a connection and make it eligable for gc.
		 */ public static const CONNECTION_DELETE:String = "connectionDelete";
		
		/**
		 *  Sent when a connection has been updated.
		 */ public static const CONNECTION_UPDATE:String = "connectionUpdate";
		
		/**
		 *  Sent when the user has requested a new selection to be made.
		 */ public static const SELECTION_CREATE:String = "selectionCreate";
		
		/**
		 *  Sent when the user has requested the completion of a selection.
		 */ public static const SELECTION_COMPLETE:String = "selectionComplete";
		
		/**
		 *  Sent when the user has requested the deletion of a selection.
		 */ public static const SELECTION_DELETE:String = "selectionDelete";
		
		/**
		 *  Notifies a selection to add the passed id
		 */ public static const ADD_TO_SELECTION:String = "addToSelection";
		
		/**
		 *  Notifies a selection to remove the passed id
		 */ public static const REMOVE_FROM_SELECTION:String = "removeFromSelection";
		
		/**
		 *  Notifies all objects to deselect.
		 */ public static const DESELECT_ALL:String = "deselectAll";
		
		/**
		 *  Notifies that an object has been selected
		 */ public static const SELECTED:String = "selected";
		
		/**
		 *  Notifies that an object has been selected
		 */ public static const DESELECTED:String = "deselected";
		
		 
		
		/**
		 * Singleton constructor.
		 * @return Reference to this singleton object.
		 */
		public static function getInstance():Nodebend {
			if (instance == null) instance = new Nodebend();
			return instance as Nodebend;
		}
		
		
		/**
		 * Register commands with the controller.
		 */
		override protected function initializeController():void 
		{
			super.initializeController();
			
			registerCommand( STARTUP, 			 ApplicationStartupCommand	);
			registerCommand( DEBUG, 			 DebugCommand 				);
			registerCommand( KEYBOARD_EVENT,	 KeyboardEventCommand 		);
			registerCommand( WORLD_LAYER_CREATE, WorldLayerCreateCommand	);
			registerCommand( NODE_TYPE_REGISTER, NodeTypeRegisterCommand 	);
			registerCommand( NODE_CREATE,		 NodeCreateCommand 			);
			registerCommand( CONNECTION_CREATE,	 ConnectionCreateCommand 	);
			registerCommand( CONNECTION_DELETE,	 ConnectionDeleteCommand 	);
			registerCommand( SELECTION_CREATE,	 SelectionCreateCommand		);
		}
		
		
		/**
		 * Starts the application.
		 */
		public function startup(window:ApplicationWindowView):void
		{
			Nodebend.debug(this, "Starting...");
			sendNotification(Nodebend.STARTUP, window);
			Nodebend.debug(this, "Started.");
		}
		
		
		/**
		 * Utility debug shortcut.
		 */
		public static function debug(origin:Object, msg:String):void {
			Nodebend.getInstance().sendNotification(Nodebend.DEBUG, new DebugVO(origin, msg));
		}
	}
	
}