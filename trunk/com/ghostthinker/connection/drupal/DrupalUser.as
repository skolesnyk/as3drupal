package com.ghostthinker.connection.drupal 
{
	
	/**
	 * A Base class for drupal users 
	 * @author 
	 */
	public class DrupalUser 
	{
		public static const ROLE_ANONYMOUS:String = "anonymous";
		public static const ROLE_AUTHENTICATED:String = "authenticated user";
		
		private var _name:String;
		private var _uid:int;
		private var _mail:String;
		private var _picture:String;
		private var _roles:Array;
		//more field should be added
		
		public function DrupalUser(name:String,uid:int,mail:String,picture:String) 
		{
			this._name = name;
			this._uid = uid;
			this._mail = mail;
			this._picture = picture;	
		}
		
		public static function fromResponse(response:Object):DrupalUser {
			
		}
		
	}
	
}