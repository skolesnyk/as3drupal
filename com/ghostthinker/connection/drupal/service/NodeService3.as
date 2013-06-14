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
		public function NodeService3( server:IServer)
		{
			SERVICE_CALL_NODE_GET = "node.retrieve"; 
			SERVICE_CALL_NODE_SAVE = "node.create"; 
			SERVICE_CALL_NODE_UPDATE = "node.update"; 
			SERVICE_CALL_NODE_DELETE = "node.delete"; 
			super( server );
		}
	
	}
	
}