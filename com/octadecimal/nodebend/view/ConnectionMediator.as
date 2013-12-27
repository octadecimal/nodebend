/*
 Mediator - PureMVC
 */
package com.octadecimal.nodebend.view 
{
	import com.octadecimal.nodebend.model.vo.ConnectionVO;
	import com.octadecimal.nodebend.Nodebend;
	import com.octadecimal.nodebend.view.components.ConnectionView;
	import com.octadecimal.nodebend.view.components.NodeView;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.nodebend.view.*;
	
	/**
	 * A node connection mediator.
	 */
	public class ConnectionMediator extends Mediator implements IMediator 
	{	
		// The origin (first) node of this connection.
		private var _originNode:NodeMediator;
		
		public function ConnectionMediator(name:String, originNode:NodeMediator, viewComponent:Object) {
			_originNode = originNode;
			super(name, viewComponent);
			
			// Listen for add to stage
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * Dispatched when the viewComponent is added to the stage, used to
		 * add any necessary stage events.
		 */
		private function onAddedToStage(e:Event):void 
		{
			// Remove event
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Listen for stage mouse up to trigger cancels.
			view.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			
			// Initially listen for mouse move events, and remove when
			// an input node is established.
			view.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}
		
		/**
		 * Sets this object as eligable for garbage collection.
		 */
		public function destroy():void
		{
			// Remove events
			view.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			
			// Remove from world
			facade.sendNotification(Nodebend.REMOVE_FROM_WORLD_LAYER, view);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onStageMouseUp(e:MouseEvent):void 
		{
			// If this connection has no input node, then it means the user
			// did not create a connection, so send the CONNECTION_CANCEL notification.
			if(!proxyData.inputNode) {
				facade.sendNotification(Nodebend.CONNECTION_CANCEL, id);
				Nodebend.debug(this, "Connection canceled: " + id);
				
				// Also delete. Later this will be handled and called later
				// by the undo queue and only cancel would take place right now.
				facade.sendNotification(Nodebend.CONNECTION_DELETE, id);
			}
		}
		
		private function onStageMouseMove(e:MouseEvent):void 
		{
			// This is dispatched only while only one input or output exists,
			// and is removed when both exist.
			var nodeView:NodeView = _originNode.getViewComponent() as NodeView;
			var projected:Point = view.globalToLocal(new Point(e.stageX, e.stageY));
			view.setAnchor0(nodeView.x, nodeView.y);
			view.setAnchor1(projected.x, projected.y);
			view.draw();
		}
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Nodebend.CONNECTION_FINISHED, Nodebend.CONNECTION_UPDATE];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) 
			{           	
				// Connection has both an input and output, save input
				// from notification body.
				case Nodebend.CONNECTION_FINISHED:
					
					proxyData.inputNode = note.getBody() as String;
					facade.sendNotification(Nodebend.CONNECTION_UPDATE, null, proxyData.inputNode);
					view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
					view.draw();
					break;	
				
				
				// Update connection
				case Nodebend.CONNECTION_UPDATE:
					
					/* TODO: Reimplement selective drawing, for now every connection redraws, hehe. */
					// Redraw if type matches input or output node id AND both are already cached (existant),
					// since we only receive updates after both are set, so we can ignore until then.
					//if(proxyData.inputNode && proxyData.outputNode) {
						//if(note.getType() == proxyData.inputNode || note.getType() == proxyData.outputNode) {
							if(proxyData.outputNode) view.setAnchor0(outputNodeView.x, outputNodeView.y);
							if(proxyData.inputNode)  view.setAnchor1(inputNodeView.x, inputNodeView.y);
						//}
					//}
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Node id. (shared with proxy)
		 */
		public function get id():String { return getMediatorName(); }
		
		/**
		 * Utility accessors.
		 */
		private function get view():ConnectionView     { return viewComponent as ConnectionView }
		private function get proxyData():ConnectionVO  { if (!_proxyData)      _proxyData      = facade.retrieveProxy(id).getData() as ConnectionVO;   return _proxyData;  }
		private function get inputNodeView():NodeView  { if (!_inputNodeView)  _inputNodeView  = facade.retrieveMediator(proxyData.inputNode).getViewComponent() as NodeView;  return _inputNodeView; }
		private function get outputNodeView():NodeView { if (!_outputNodeView) _outputNodeView = facade.retrieveMediator(proxyData.outputNode).getViewComponent()  as NodeView;  return _outputNodeView;  }
		
		/**
		 * Cache
		 */
		private var _proxyData:ConnectionVO;
		private var _inputNodeView:NodeView;
		private var _outputNodeView:NodeView;

	}
}
