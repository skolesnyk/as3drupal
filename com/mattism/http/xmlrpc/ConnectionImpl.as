﻿/**
* @author	Matt Shaw <xmlrpc@mattism.com>
* @url		http://sf.net/projects/xmlrpcflash
* 			http://www.osflash.org/doku.php?id=xmlrpcflash			
*
* @author   Daniel Mclaren (http://danielmclaren.net)
* @note     Updated to Actionscript 3.0
*/

package com.mattism.http.xmlrpc
{
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.events.IOErrorEvent;
	
	import com.mattism.http.xmlrpc.Connection;
	import com.mattism.http.xmlrpc.MethodCall;
	import com.mattism.http.xmlrpc.MethodCallImpl;
	import com.mattism.http.xmlrpc.MethodFault;
	import com.mattism.http.xmlrpc.MethodFaultImpl;
	import com.mattism.http.xmlrpc.Parser;
	import com.mattism.http.xmlrpc.ParserImpl;
	
	public class ConnectionImpl
	extends EventDispatcher
	implements Connection {
	
		// Metadata
		private var _VERSION:String = "1.0.0";
		private var _PRODUCT:String = "ConnectionImpl";
		
		private var ERROR_NO_URL:String =  "No URL was specified for XMLRPCall.";
		
		private var _url:String;
		private var _method:MethodCall;
		private var _rpc_response:Object;
		private var _parser:Parser;
		private var _response:URLLoader;
		private var _parsed_response:Object;
		
		private var _fault:MethodFault;
		
		public function ConnectionImpl( url:String ) {
			//prepare method response handler
			//this.ignoreWhite = true;
			
			//init method
			this._method = new MethodCallImpl();
			
			//init parser
			this._parser = new ParserImpl();
			
			//init response
			this._response = new URLLoader();
			this._response.addEventListener(Event.COMPLETE, this._onLoad);
			
			if (url){
				this.setUrl( url );
			}
			
			_response.addEventListener(IOErrorEvent.IO_ERROR, ioerror); 
			
		}
		
		function ioerror( e:Event ) {
			debug("io error " + e.toString());
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
		}
		
		public function call( method:String, header:URLRequestHeader = null ):void { this._call( method, header ); }
	
		private function _call( method:String, header:URLRequestHeader ):void {
			if ( !this.getUrl() ){
				throw Error(ERROR_NO_URL);
			}
			else {		
				this.debug( "Call -> " + method+"() -> " + this.getUrl());
				
				this._method.setName( method );
				
				var request:URLRequest = new URLRequest();
				request.contentType = 'text/xml';
				request.data = this._method.getXml();
				request.method = URLRequestMethod.POST;
				request.url = this.getUrl();
				debug(this._method.getXml());
				
				if (header != null) {
					request.requestHeaders.push(header);
				}
				
				this._response.load(request);
			}
		}
	
		private function _onLoad( evt:Event ):void {
			
			var responseXML:XML = new XML(this._response.data);
			
			if (responseXML.fault.length() > 0)
			{
				// fault
				var parsedFault:Object = parseResponse(responseXML.fault.value.*[0]);
				_fault = new MethodFaultImpl( parsedFault );
				debug("XMLRPC Fault (" + _fault.getFaultCode() + "):\n" + _fault.getFaultString());
				
				dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
			}
			else if (responseXML.params)
			{
				_parsed_response = parseResponse(responseXML.params.param.value[0]);
				
				dispatchEvent(new Event(Event.COMPLETE));
			}
			else
			{
				dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
			}
		}
		
		private function parseResponse(xml:XML):Object
		{
			return this._parser.parse( xml );
		}
			
		//public function __resolve( method:String ):void { this._call( method ); }
	
		public function getUrl():String { return this._url; }	
	
		public function setUrl( a:String ):void { this._url = a; }
		
		public function addParam( o:Object, type:String ):void { this._method.addParam( o,type ); }
		
		public function removeParams():void { this._method.removeParams(); }
		
		public function getResponse():Object { return this._parsed_response; }
	
		public function getMethod():Object { return this._method; } //added by metscher 10.08.2008 - 21:24
		
		public function getFault():MethodFault { return this._fault; }
		
		override public function toString():String { return '<xmlrpc.ConnectionImpl Object>'; }
		
		private function debug( a:String ):void {
			trace(a)
		}
	}
}