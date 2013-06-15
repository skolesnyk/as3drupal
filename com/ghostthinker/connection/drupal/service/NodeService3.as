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
	public class NodeService3 extends NodeService
	{
		
		public static const SERVICE_CALL_NODE_COMMENTS = "node.comments"; 
		public static const EVENT_NODE_COMMENTS:String = "node.onCommentsLoaded";
		
		public function NodeService3( server:IServer)
		{
			SERVICE_CALL_NODE_GET = "node.retrieve"; 
			SERVICE_CALL_NODE_SAVE = "node.create"; 
			SERVICE_CALL_NODE_UPDATE = "node.update"; 
			SERVICE_CALL_NODE_DELETE = "node.delete"; 
			
			super( server );
		}
		
		/**
		 * Load comments by node
		 * @param nid the nid of the node
		 */
		public function loadComments( nid:int, count:int=-1,offset:int=-1, callback:Function=null):void
		{
			var sc:ServiceCall = new ServiceCall( SERVICE_CALL_NODE_COMMENTS );
			sc.addParam( nid, ServiceCall.TYPE_INT);
			
			if (count >= 0 ) {
				sc.addParam( count, ServiceCall.TYPE_INT);
			}
			if (offset >= 0 ) {
				sc.addParam( offset, ServiceCall.TYPE_INT);
			}
			this._server.call(sc,callback?callback:onCommentsLoaded);
		}
		
		/**
		 * Event which is triggered by the response of node.load
		 * @param	evt
		 */
		public function onCommentsLoaded( evt:Event ):void
		{
			trace(evt.target.getResponse());
			if(!containsError(evt.target.getResponse())){
				this.dispatchEvent(new ServiceEvent(evt.target.getResponse(), NodeService3.EVENT_NODE_COMMENTS));

			}
			else {
				
			}
		}
	
	}
	
}