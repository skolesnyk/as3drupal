package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Johannes Metscher
	 */
	public class AbstractService extends EventDispatcher
	{	
		//error strings
		public static const ERROR_ACCESS_DENIED:String = "Access denied.";
		public static const ERROR_ACCESS_DENIED_GERMAN:String = "Zugriff verweigert";
		public static const ERROR_INVALID_APIKEY:String = "Invalid API key.";
		

		
		protected var _server:IServer;
		private   var _errors:Array;
		
		public function AbstractService(server:IServer ) 
		{
			this._server = server;
			this._errors = new Array();
			this.addError(AbstractService.ERROR_ACCESS_DENIED);
			this.addError(AbstractService.ERROR_ACCESS_DENIED_GERMAN);
			
			this.addError(AbstractService.ERROR_INVALID_APIKEY);
		}
		
		public function containsError(response:Object):Boolean{
			
			for each(var error:String in this._errors){
				if (error == response) {
					this.dispatchEvent(new ServiceEvent(response,ServiceEvent.EVENT_ERROR));
					return true;
				}
			}
			return false;
		}
		
		protected function addError(str:String):void{
			this._errors.push(str);
		}
	}
	
}