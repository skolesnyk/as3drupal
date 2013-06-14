package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.DrupalNode
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Johannes Metscher
	 */
	public class NodeService extends AbstractService
	{
		
		public static var EVENT_NODE_LOAD:String 	 = "node.onNodeLoad";
		public static var EVENT_NODE_SAVE:String	 = "node.onNodeSave";
		public static var EVENT_NODE_DELETE:String = "node.onNodeDeleted";
		public static var SERVICE_CALL_NODE_GET:String = "node.get"; 
		public static var SERVICE_CALL_NODE_SAVE:String = "node.save"; 
		public static var SERVICE_CALL_NODE_DELETE:String = "node.delete"; 
		
		
		public function NodeService( server:IServer)
		{
			super( server );
		}
		
		/**
		 * Load a node from Drupal
		 * @param nid the nid of the node
		 */
		public function load( nid:int, callback:Function=null):void
		{
			var sc:ServiceCall = new ServiceCall( SERVICE_CALL_NODE_GET );
			sc.addParam( nid,ServiceCall.TYPE_INT);
			
			this._server.call(sc,callback?callback:onLoaded);
		}
		
		/**
		 * Event which is triggered by the response of node.load
		 * @param	evt
		 */
		public function onLoaded( evt:Event ):void
		{
			trace(evt.target.getResponse());
			if(!containsError(evt.target.getResponse())){
				this.dispatchEvent(new ServiceEvent(evt.target.getResponse(), NodeService.EVENT_NODE_LOAD));

			}
			else {
				
			}
		}
		/**
		 * Save a node. The response will be the nid
		 * @param drupalnode - A node object. Upon creation, node object must include "type". Upon update, node object must include "nid" and "changed".
		 */
		public function save(drupalnode:DrupalNode):void{
			var node:Object = drupalnode.node;	
			if(!node.type){
				throw new Error("node ojbect in node.save requires a \"type\" value!"); 
			}
			//update
			if(node.nid){
				//set the changed value if not yet set
				if(!node.changed){
					node.changed = new Date().getTime();
				}
			}

			var sc:ServiceCall = new ServiceCall(SERVICE_CALL_NODE_SAVE);
			sc.addParam(node,ServiceCall.TYPE_STRUCT);
			this._server.call(sc,this.onSaved);
			
		}
		
		/**
		 * Event which is triggered by the response of node.save
		 * @param	evt
		 */
		public function onSaved( evt:Event ):void
		{
			trace("nodeservice.onSaved: nid=" + evt.target.getResponse());
			//response (should) hold the nid
			this.dispatchEvent(new ServiceEvent(evt.target.getResponse(),NodeService.EVENT_NODE_SAVE));
		}
		
		/**
		 * Save a node and fetch the node object afterwards
		 * @param	evt
		 */
		public function saveAndLoad(drupalnode:DrupalNode):void{
			var node:Object = drupalnode.node;	
			if(!node.type){
				throw new Error("node ojbect in node.save requires a \"type\" value!"); 
			}
			//update
			if(node.nid){
				//set the changed value if not yet set
				if(!node.changed){
					node.changed = new Date().getTime();
				}
			}

			var sc:ServiceCall = new ServiceCall(SERVICE_CALL_NODE_SAVE);
			sc.addParam(node,ServiceCall.TYPE_STRUCT);
			this._server.call(sc,this.onSavedNowLoad);
		}
		
		/**
		 * Event which is triggered by the response of node.save
		 * @param	evt
		 */
		public function onSavedNowLoad( evt:Event ):void{
			trace("nodeservice.onSaved: nid=" + evt.target.getResponse());
			//load the created nid
			load(evt.target.getResponse(), onSavedAndLoaded);
		}
		public function onSavedAndLoaded( evt:Event ):void{
			this.dispatchEvent(new ServiceEvent(evt.target.getResponse(),NodeService.EVENT_NODE_SAVE));
		}
		

		/**
		 * Delete a node from Drupal. Function cannot be called "delete" because "delete" is a keyword in as
		 * @param nid the nid of the node
		 */
		public function deleteNode( nid:int ):void{
			var sc:ServiceCall = new ServiceCall(SERVICE_CALL_NODE_DELETE);
			sc.addParam( nid,ServiceCall.TYPE_INT);
			this._server.call(sc,this.onDeleted);
		}
		
		/**
		 * Event which is triggered by the response of node.delete
		 * @param	evt
		 */
		public function onDeleted( evt:Event ):void
		{
			//todo: catch errors
			this.dispatchEvent(new ServiceEvent(evt.target.getResponse(),NodeService.EVENT_NODE_DELETE));
		}
	}
	
}