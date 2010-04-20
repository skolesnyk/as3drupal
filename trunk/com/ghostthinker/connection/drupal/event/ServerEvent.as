package com.ghostthinker.connection.drupal.event
{
	
	import flash.events.Event;

	public class ServerEvent extends Event
	{ 
		public static const CONNECTION_ERROR:String = "connection error";
		public static const SOME_OTHER_ERROR:String = "dev/null";
		
		private var _response:Object;
		
		public function ServerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);

			

		}	
	}
}