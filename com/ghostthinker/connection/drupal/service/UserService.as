package com.ghostthinker.connection.drupal.service 
{

	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	import com.ghostthinker.connection.drupal.DrupalUser;
	
	import flash.events.Event;
	
	/**
	 * Implemation of the drupal system_service.module
	 *
	 */
	public class UserService extends AbstractService
	{
		public static const EVENT_ON_LOGIN:String  = "user.onLogin";
		public static const EVENT_ON_LOGOUT:String = "user.onLogout";
		//error strings as they come from drupal
		public static const ERROR_LOGIN:String = "Wrong username or password."; 
		
		public function UserService( server:IServer)
		{
			super( server );
			this.addError(ERROR_LOGIN);
			
		}

		public function login(username:String,password:String):void
		{
			var sc:ServiceCall = new ServiceCall("user.login");
			sc.addParam(username, "string");
			sc.addParam(password, "string");
			
			this._server.call(sc,this.onLogin);
			//sc.addEventListener(Event.COMPLETE, onUserLogin);
		}
		private function onLogin(evt:Event):void{
			
			var rep:Object = evt.target.getResponse();
			//set the user var if we are logged in
			if( !containsError( evt.target.getResponse() ) ){
				if (evt.target.getResponse().user.name) {
						//init the new session id 
						_server.initSession(evt.target.getResponse().sessid);
						this._server.initUser(evt.target.getResponse().user);
				}
				this.dispatchEvent(new ServiceEvent(evt.target.getResponse(),UserService.EVENT_ON_LOGIN));
			}
			else {

			}
		}
		
		
		public function logout():void
		{
			var sc:ServiceCall = new ServiceCall('user.logout');
			//no params
			this._server.call(sc,this.onLogout);
		}
		
		private function onLogout(e:Event):void {

			this.dispatchEvent(new ServiceEvent(e.target.getResponse(),UserService.EVENT_ON_LOGOUT));
		}
		
		
		/*
		public function save(username:String,password:String):void
		{
			//tbi
		}		
		public function load(uid:int):void
		{
			var sc:ServiceCall = new ServiceCall();
			sc.addParam(uid, "int");
			sc.addEventListener(Event.COMPLETE, onUserLoad);
		}		
		
		
		public function onConnected( evt:Event ):void 
		{
			evt.target.removeEventListener(Event.COMPLETE, onConnected);
			var response:DrupalResponse = createDrupalResponseWithListeners( evt.target );

			if ( !response.containsError && response.sessid  )
			{
				_sessid = response.sessid;
				traceDebugMessage ( "SID = " +  _sessid );
				dispatchEvent(new DrupalEvent(response,DrupalEvent.CONNECTED));
			}
		}
		*/
	}
	
}