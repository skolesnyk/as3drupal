package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Johannes Metscher
	 */
	public class ViewsService extends AbstractService
	{
		
		public static const EVENT_VIEW_LOAD:String = "views.onViewLoad";
		public static const ERROR_VIEW_NOT_FOUND:String	=	"View does not exist.";
		
		public function ViewsService( server:IServer)
		{
			super( server );
			this.addError(ERROR_VIEW_NOT_FOUND);
		}
		
		/**
		 * Load a view from Drupal
		 * @param nid the nid of the node
		 */
		public function load( viewName:String , fields:Array , args:Array,offset:String, limit:String ):void
		{
			var sc:ServiceCall = new ServiceCall('views.get');
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