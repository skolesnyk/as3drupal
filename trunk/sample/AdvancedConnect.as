package sample
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.Server;
	import com.ghostthinker.connection.drupal.server.XMLRPCServer;
	import com.ghostthinker.connection.drupal.service.NodeService;
	import com.ghostthinker.connection.drupal.service.SystemService;
	import com.ghostthinker.connection.drupal.service.UserService;
	
	import flash.display.Sprite;
	
	/**
	 * Simpleconnect is a main class for demonstrating a simple drupal connection, login a user and load a node
	 * @author Stefan Hoerterer <stefan.hoerterer@gmail.com> 
	 */
	public class AdvancedConnect extends Sprite
	{
		public static const DRUPAL_URL:String =  "http://drupalurl.sample";
		public static const API_KEY:String = "apikey";
		public static const API_DOMAIN:String = "apidomain.sample";
		
		private var _server:Server;
		private var systemService:SystemService;


		/**
		 * Main function. 
		 */ 
		public function AdvancedConnect() 
		{
			this._server = new XMLRPCServer(DRUPAL_URL,null);
			
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
			nodeService.load(1);
			//watch the load event
			nodeService.addEventListener(NodeService.EVENT_NODE_LOAD,onNodeLoaded);
			
			
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
				//userService.addEventListener(UserService.EVENT_ON_LOGOUT,onLogout);
			}
			
		}
		
		private function onLogin(evt:ServiceEvent):void{
			if(evt.response == "Wrong username or password."){
				debug("loggin failed");
			}	
			else{
				debug("logged in user "+evt.response.user.name);
				//goto main
				initComplete();
			}
		}
		private function onLogout(evt:ServiceEvent):void{
			debug("loggout");
		}
		
		private function onNodeLoaded(evt:ServiceEvent):void{
			
			debug("Node title: "+evt.response.title);
		}
		
		private function debug(message:String,serverity:String="info"):void{
			trace(message);
		}

		
	}
	
}