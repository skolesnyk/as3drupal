package sample
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.XMLRPCServer;
	import com.ghostthinker.connection.drupal.service.NodeService;
	import com.ghostthinker.connection.drupal.service.SystemService;
	import com.ghostthinker.connection.drupal.service.UserService;
	
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	import flash.text.TextField;
	
	/**
	 * Simpleconnect is a main class for demonstrating a simple drupal connection, login a user and load a node
	 * @author Stefan Hoerterer <stefan.hoerterer@gmail.com> 
	 */
	public class SimpleConnect extends Sprite
	{
		public static const DRUPAL_URL:String =  "http://drupalurl.sample";
		public static const API_KEY:String = "apikey";
		public static const API_DOMAIN:String = "apidomain.sample";
		
		private var _server:XMLRPCServer;
		private var systemService:SystemService;
		
		private var _dtOutput:TextField;


		/**
		 * Main function. 
		 */ 
		public function SimpleConnect() 
		{
			
			_dtOutput = new TextField();
			_dtOutput.width = 400;
			_dtOutput.multiline = true;
			debug("Start");
			addChild(_dtOutput);
			
			
			this._server = new XMLRPCServer(DRUPAL_URL,API_KEY,API_DOMAIN);
			_server.addEventListener(IOErrorEvent.IO_ERROR, onConnectionError);
			systemService = new SystemService(_server);	
			systemService.connect();
			systemService.addEventListener(SystemService.EVENT_ON_CONNECTED,onConnected);
			
		}
		
		/**
		 * Function initComplete is called when we have a valid connection and user.
		 * It simply loades the node with nid 1
		 */
		private function initComplete():void{
			
			var nodeService:NodeService = new NodeService(_server);
			//nodeService.load(1);
			//watch the load event
			//nodeService.addEventListener(NodeService.EVENT_NODE_LOAD,onNodeLoaded);
			//nodeService.deleteNode(4);
			//nodeService.addEventListener(NodeService.EVENT_NODE_DELETE,onNodeDeleted);
			systemService.getServices();
			
			/*
			var viewsService:ViewsService = new ViewsService(_server);
			viewsService.load("Blogs");
			viewsService.addEventListener(ViewsService.EVENT_VIEW_LOAD,onViewLoad);			
			*/
		}
		
		private function onConnected(evt:ServiceEvent):void {
			debug("Connected - sessid: "+evt.response.sessid);
		   var userService:UserService		= new UserService(_server); 
			//no valid user (anonymous), so log in
			if(!evt.response.user.name){
				userService.login("testuser","testpassword");
				userService.addEventListener(UserService.EVENT_ON_LOGIN,onLogin);
			}
			else{
				debug("Valid username is "+evt.response.user.name);
				//goto main
				initComplete();
				
				//userService.logout();
				userService.addEventListener(UserService.EVENT_ON_LOGOUT,onLogout);
			}
			
		}
		
		
		private function onConnectionError(evt:IOErrorEvent):void{
			trace("Cannot connect to " + DRUPAL_URL);
		}
		
		private function onLogin(evt:ServiceEvent):void{
			if(evt.service.containsError(evt.response)){
				debug("loggin failed "+evt.response);
			}	
			else{
				debug("login");
				debug("logged in user "+evt.response.user.name);
				//goto main
				initComplete();
			}
		}
		private function onLogout(evt:ServiceEvent):void{
			debug("loggout");
		}
		
		private function onNodeLoaded(evt:ServiceEvent):void{
			
			if(evt.service.containsError(evt.response)){
				debug("Error loading node: "+evt.response);
			}
			else{
				debug("Node title: "+evt.response.title);
			}
		}
		
		private function onNodeDeleted(evt:ServiceEvent):void{
			
			debug(""+evt.response);
			if(evt.service.containsError(evt.response)){
				debug("Error deleting node: "+evt.response);
			}
			else{
				debug("Node title: "+evt.response.title);
			}
		}
		private function onViewLoad(evt:ServiceEvent):void{
			
			if(evt.service.containsError(evt.response)){
				debug("Error loading view: "+evt.response);
			}
			else{
				debug("View title: "+evt.response.title);
			}
		}
		
		private function debug(message:String,serverity:String="info"):void{
			trace(message);
			_dtOutput.appendText("\n"+message);
		}

		
	}
	
}