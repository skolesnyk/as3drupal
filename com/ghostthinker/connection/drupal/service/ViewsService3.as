package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Johannes Metscher
	 */
	public class ViewsService3 extends ViewsService
	{
		
		public static const SERVICE_CALL_VIEWS_LOAD:String = "views.retrieve"; 
		
		public function ViewsService3( server:IServer)
		{
			super( server );
			this.addError(ERROR_VIEW_NOT_FOUND);
		}
		
		/**
		 * Load a view from Drupal
		 * @param nid the nid of the node
		 */
		override public function load( viewName:String , fields:Array , args:Array,offset:String, limit:String ):void
		{
			var sc:ServiceCall = new ServiceCall(SERVICE_CALL_VIEWS_LOAD);
			sc.addParam( viewName, ServiceCall.TYPE_STRING);
			sc.addParam( fields, ServiceCall.TYPE_ARRAY);
			sc.addParam( args, ServiceCall.TYPE_ARRAY);
			this._server.call(sc,onLoaded);
		}
		
		/**
		 * Event which is triggered by the response to node.load
		 * @param	evt
		 */
		public function onLoaded( evt:Event ):void
		{
			//todo: catch errors
			this.dispatchEvent(new ServiceEvent(evt.target.getResponse(),ViewsService.EVENT_VIEW_LOAD));
		}
		
	}
	
}