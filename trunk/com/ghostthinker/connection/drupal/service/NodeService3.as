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
		
		public static const SERVICE_CALL_NODE_GET:String = "node.retrieve"; 
		public static const SERVICE_CALL_NODE_SAVE:String = "node.create"; 
		public static const SERVICE_CALL_NODE_UPDATE:String = "node.update"; 
		public static const SERVICE_CALL_NODE_DELETE:String = "node.delete"; 
		
		
		public function NodeService3( server:IServer)
		{
			super( server );
		}
	
	}
	
}