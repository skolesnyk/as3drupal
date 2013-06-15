package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Johannes Metscher
	 */
	public class ViewsService3  extends AbstractService
	{
		public static const EVENT_VIEW_LOAD:String = "views.onViewLoad";
		public static const ERROR_VIEW_NOT_FOUND:String	=	"View does not exist.";
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
		public function load( view_name:String , display_id:String="default" , args:Array = null,offset:String="0", limit:String="10",filters:Array = null ):void
		{
 			var sc:ServiceCall = new ServiceCall(SERVICE_CALL_VIEWS_LOAD);
			sc.addParam( view_name, ServiceCall.TYPE_STRING);
			sc.addParam( display_id, ServiceCall.TYPE_STRING);
			if(args){
				sc.addParam( args, ServiceCall.TYPE_ARRAY);
			}
			/*
			if(offset){
				sc.addParam( offset, ServiceCall.TYPE_STRING);
			}
			if(limit){
				sc.addParam( limit, ServiceCall.TYPE_STRING);
			}
			if(filters){
				sc.addParam( filters, ServiceCall.TYPE_ARRAY);
			}
			*/
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