package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	
	import flash.events.Event;
	
	/**
	 * Implemation of the drupal system_service.module
	 *
	 */
	public class SystemService extends AbstractService
	{
		public static const EVENT_ON_CONNECTED:String ="onConnected";
		
		public function SystemService(server:IServer)
		{
			super(server);
		}
//services
		public function connect():void
		{
			var sc:ServiceCall = new ServiceCall("system.connect");
			//no parameter	
			_server.call(sc, this.onConnected);
		}
		public function mail():void{
			//tbi
		}
		public function getVariable(name:String,default_:String):void
		{
			
		}
		public function setVariable(name:String,default_:String):void
		{
			
		}
		public function moduleExists(module:String):void
		{
			
		}
		public function getServices():void
		{
			_server.call(new ServiceCall("system.getServices"),this.onGetServices);
		}
		public function cacheClearAll():void
		{
			
		}
		
//callbacks		
		protected function onConnected(evt:Event):void {
			if(!containsError(evt.target.getResponse())){
				if(evt.target.getResponse().sessid){
					this._server.initSession(evt.target.getResponse().sessid);
					//we have a valid user
					if(evt.target.getResponse().user && evt.target.getResponse().user.name){
						this._server.initUser(evt.target.getResponse().user);
					}
				}

				dispatchEvent(new ServiceEvent(evt.target.getResponse(),SystemService.EVENT_ON_CONNECTED));
			}
			else {
				//done by abstract class
			}
		}
		protected function onGetServices(evt:Event):void{
			var res:Object = evt.target.getResponse();
		}
		
		
	}
	
}