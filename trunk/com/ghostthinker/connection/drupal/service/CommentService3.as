package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.DrupalComment;
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class CommentService3 extends AbstractService 
	{
		public static var EVENT_COMMENT_LOAD:String 	 = "comment.load";
		public static var EVENT_COMMENT_SAVE:String	 = "comment.save";
		public static var EVENT_COMMENT_DELETE:String = "comment.delete";
		
		public static var SERVICE_CALL_COMMENT_LOAD:String = "comment.retrieve"; 
		public static var SERVICE_CALL_COMMENT_INSERT:String = "comment.create"; 
		public static var SERVICE_CALL_COMMENT_UPDATE:String = "comment.update"; 
		public static var SERVICE_CALL_COMMENT_DELETE:String = "comment.delete"; 
		
		public function CommentService3( server:IServer)
		{
			super( server );	
		}
		
		public function loadComment(cid:int, callback:Function=null):void
		{
			var sc:ServiceCall = new ServiceCall( SERVICE_CALL_COMMENT_LOAD );
			sc.addParam( cid, ServiceCall.TYPE_INT);
			this._server.call(sc,callback?callback:onLoaded);
		}
		
		/**
		 * Event which is triggered by the response of comment load
		 * @param	evt
		 */
		public function onLoaded( evt:Event ):void
		{
			if(!containsError(evt.target.getResponse())){
				this.dispatchEvent(new ServiceEvent(evt.target.getResponse(), CommentService3.EVENT_COMMENT_LOAD));
			}
			else {
				
			}
		}
		
		/**
		 * Save a node. The response will be the nid
		 * @param drupalnode - A node object. Upon creation, node object must include "type". Upon update, node object must include "nid" and "changed".
		 */
		public function save(comment:DrupalComment):void{
			var entity:Object = comment.entity;	
			if(!entity.node_type){
				throw new Error("node ojbect in comment.save requires a \"node_type\" value!"); 
			}
			//update
			if(entity.cid){
				//set the changed value if not yet set
				if(!entity.changed){
					entity.changed = new Date().getTime();
				}
				//UPDATE
			//insert
			}else {
				//entity.new = 1;
				_insertComment(entity);
			}

		}
		
		private function _insertComment(comment:Object):void {
			var sc:ServiceCall = new ServiceCall(SERVICE_CALL_COMMENT_INSERT);
			sc.addParam(comment,ServiceCall.TYPE_STRUCT);
			this._server.call(sc,this.onSaved);
		}
		
		/**
		 * Event which is triggered by the response of node.save
		 * @param	evt
		 */
		public function onSaved( evt:Event ):void
		{
			var resp = evt.target.getResponse();
			var p = this;
			//relaod the entity
			loadComment(resp.cid, function(e:Event) {
				p.dispatchEvent(new ServiceEvent(e.target.getResponse(),CommentService3.EVENT_COMMENT_SAVE));
			});
			//response (should) hold the nid
			

		}
		
	}

}