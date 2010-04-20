package com.ghostthinker.connection.drupal.service 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class ServiceCall extends EventDispatcher
	{
		public static const TYPE_INT:String = "int";
		public static const TYPE_STRING:String = "string";
		public static const TYPE_ARRAY:String = "array";
		public static const TYPE_STRUCT:String = "struct";
		
		private var _serviceName:String;
		private var _parameters:Array;
		
		public function ServiceCall(serviceName:String) 
		{
			this._serviceName = serviceName;
			this._parameters = new Array();
		}
		
		public function addParam(param:Object,type:String=ServiceCall.TYPE_STRING):void {
			var paramArray:Array = new Array();
			paramArray["type"]  = type;
			paramArray["value"] = param;
			this._parameters.push(paramArray);
		}
		public function addParamAtBegin(param:Object,type:String=ServiceCall.TYPE_STRING):void {
			var paramArray:Array = new Array();
			paramArray["type"]  = type;
			paramArray["value"] = param;
			this._parameters.splice(0, 0, paramArray);
		}
		
		public function get serviceName():String {
			return this._serviceName;
		}
		
		public function get parameters():Array {
			return _parameters;
		}
		
		
	}
	
}