package com.ghostthinker.connection.drupal.server 
{
	import com.ghostthinker.connection.drupal.event.ServerEvent;
	import com.ghostthinker.connection.drupal.service.ServiceCall;
	import flash.events.Event;

	
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class Server extends EventDispatcher
	{
		protected var _serverURL:String;
		private var _apikey:String;
		private var _apiDomain:String;
		private var _sessid:String;
		private var _user:Object;
		private var _connected:Boolean;
	
		public function Server(serverURL:String,apikey:String=null,apiDomain:String=null) 
		{
			this._serverURL	= serverURL;
			this._apikey	= apikey;
			//if no api domain is given -> use server url
			this._apiDomain = apiDomain?apiDomain:serverURL;
			this._sessid	= null
			this._connected	= false;
		}
		/**
		 * prepare the request call with additional info
		 * @param 
		 */
		public  function prepareCall(serviceCall:ServiceCall,responseFunction:Function):void {
			
			//already connected, prepare call
			if(this._connected){
				if (_sessid) {
					serviceCall.addParamAtBegin(_sessid, ServiceCall.TYPE_STRING);
				}
				//if api key is set, inject the required details.
				if(_apikey){
					hashServiceCall(serviceCall);
				}
			} 
			else{
				
			}
			
		}
	   /**
		* A service call with apikey and session id has the following params (copied from services documentation):
		* 	
		* 	string hash (required)
		*    	A valid API key.
		*	string domain_name (required)
		*	    A valid domain for the API key.
		*	string domain_time_stamp (required)
		*	    Time stamp used to hash key.
		*	string nonce (required)
		*	    One time use nonce also used hash key.
		*	string sessid (required)
		* 
		* @param serviceCall - a ServiceCall. The session key should already be in the service call and is not inserted by this function
		*/
		protected function hashServiceCall(serviceCall:ServiceCall):void{
			
			//create the hashed string, a composition or diffrent keys
            var timestamp:String = (Math.round((new Date().getTime())/1000)).toString();
            var nonce:String = createNonce();
            var hash:String = timestamp + ";";
            hash += this._apiDomain + ";";
            hash += nonce + ";";
            hash += serviceCall.serviceName;
            
            //the hased api key
            var apiHash:String = com.adobe.crypto.HMAC.hash(this._apikey,hash, com.adobe.crypto.SHA256);
            
            //now insert the details into the serviceCall - the order is important
            serviceCall.addParamAtBegin(nonce);
            serviceCall.addParamAtBegin(timestamp);
            serviceCall.addParamAtBegin(this._apiDomain);
            serviceCall.addParamAtBegin(apiHash);
          
        }

        protected function createNonce():String
        {
        	var len:int = 13;
            var alphabet:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var alphabetArray:Array = alphabet.split("");
            var nonce:String = "";
            
            for (var i:Number = 0; i < len; i++)
            {
                nonce += alphabetArray[Math.floor(Math.random() * alphabetArray.length)];
            }
            return nonce;
        }

				
		protected function errorHandler(evt:Event):void {
			
			this.dispatchEvent(new ServerEvent(ServerEvent.CONNECTION_ERROR));
		}
		
		public function set sessid(sessid:String):void{
			this._connected = true;
			trace("sessid = " + sessid);
			this._sessid = sessid;
		}
		public function get sessid():String{
			return this._sessid;
		}
		
		public function get user():Object{
			return this._user;
		}
		
		public function set user(user:Object):void{
			this._user = user;
		}
		
		public function get connected():Boolean {
			return _connected;
		}
		
	}
	
}