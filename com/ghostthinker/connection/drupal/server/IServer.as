package com.ghostthinker.connection.drupal.server
{
	import com.ghostthinker.connection.drupal.service.ServiceCall;
	/**
	 * Interface to force implementations. Services only communicate with server via interface
	 * */
	public interface IServer
	{
		  function call(serviceCall:ServiceCall,responseFunction:Function):void;
		  
		  function initSession(sessid:String):void;
		  
		  function initUser(user:Object):void;
		  
	}
}