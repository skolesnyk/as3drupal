package com.ghostthinker.connection.drupal.server 
{

	import com.ghostthinker.connection.drupal.service.ServiceCall;
	import com.mattism.http.xmlrpc.Connection;
	import com.mattism.http.xmlrpc.ConnectionImpl;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	/**
	 * XMLRPC server for drupal services module 7.x-3.x and 6.x-3.x
	 * @author 
	 */
	public class XMLRPCServer3 extends Server implements IServer
	{
		private var _useSession:Boolean;
		private var _csrfToken:String;
		private var _host:String;

		public function XMLRPCServer3(host:String, serviceEndpoint:String, useSession:Boolean){

			_host = host;
			_useSession = useSession;
			
			super(host + serviceEndpoint, null,null); 
		}
		
		
		public  function call(serviceCall:ServiceCall, responseHandler:Function):void {
			
			if (_useSession == true) {
				var url:String = this._host + "/services/session/token";
				var request:URLRequest = new URLRequest(url);
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE,function(e:Event){
					_csrfToken = e.target.data;
					
					_call(serviceCall, responseHandler);
				});
				loader.load(request);
			}else{
				this._call(serviceCall, responseHandler);
			}
		}
		
		public function _call(serviceCall:ServiceCall, responseHandler:Function):void {
					//prepareCall(serviceCall,responseHandler);
			//create the rpc connection
			
			
			var rpc:Connection = new ConnectionImpl(this._serverURL );
			//add the parameters
			for (var i:uint = 0; i < serviceCall.parameters.length;i++ ) {
				
				switch(serviceCall.parameters[i]["type"]) {
					default:
						rpc.addParam(serviceCall.parameters[i]["value"],serviceCall.parameters[i]["type"]);
				}
			}
			
			var header:URLRequestHeader = null;
			//add csrf token 
			if (_useSession) {
				header = new URLRequestHeader("X-CSRF-Token",this._csrfToken);
			}
			
			rpc.call(serviceCall.serviceName, header);
			rpc.addEventListener(Event.COMPLETE, responseHandler);
			rpc.addEventListener(ErrorEvent.ERROR, errorHandler);
			rpc.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
		}
		/**
		 * @override
		 * @param	serviceCall
		 * @param	responseFunction
		 */
		override public  function prepareCall(serviceCall:ServiceCall,responseFunction:Function):void {
			
		}

		public function initSession(sessid:String):void{
			this.sessid = sessid;
		}
		  
		public function initUser(user:Object):void{
			this.user = user;
		}
		
		override protected function errorHandler(evt:Event):void 
		{
			trace("XMLRPCService - "+evt.target.getResponse());
		}


	}
	
}