package com.ghostthinker.connection.drupal.event
{
	import com.ghostthinker.connection.drupal.service.AbstractService;
	
	import flash.events.Event;

	public class ServiceEvent extends Event
	{ 
		public static const EVENT_ERROR:String = "serviceError";
	
		private var _response:Object;
		
		public function ServiceEvent(response:Object,type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._response = response;
			

		}
		
		public function get response():Object{
			return this._response;
		}
		
		public function get service():AbstractService{
			if(!(this.target is AbstractService))
				throw new Error("Only services may dispatch ServiceEvents"); 
			return AbstractService(this.target);
		}
		
		
	}
}