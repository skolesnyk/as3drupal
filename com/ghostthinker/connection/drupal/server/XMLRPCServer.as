package com.ghostthinker.connection.drupal.server 
{

	import com.ghostthinker.connection.drupal.service.ServiceCall;
	import com.mattism.http.xmlrpc.Connection;
	import com.mattism.http.xmlrpc.ConnectionImpl;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class XMLRPCServer extends Server implements IServer
	{

		public function XMLRPCServer(serverURL:String,apiKey:String=null,apiDomain=null)
		{
			serverURL = serverURL; //"/xmlrpc.php";
			super(serverURL, apiKey,apiDomain); 
			

		}
		
		public  function call(serviceCall:ServiceCall,responseHandler:Function):void {
			//call the parent function to prepare/embed the needed values like session id, apikey...
		//	super.call(serviceCall,responseFunction);
			prepareCall(serviceCall,responseHandler);
			//create the rpc connection
			
			var rpc:Connection = new ConnectionImpl(this._serverURL );
			//add the parameters
			for (var i:uint = 0; i < serviceCall.parameters.length;i++ ) {
				
				switch(serviceCall.parameters[i]["type"]) {
					default:
						rpc.addParam(serviceCall.parameters[i]["value"],serviceCall.parameters[i]["type"]);
				}
			}
				
			rpc.call(serviceCall.serviceName);
			rpc.addEventListener(Event.COMPLETE, responseHandler);
			rpc.addEventListener(ErrorEvent.ERROR, errorHandler);
			rpc.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);

	
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