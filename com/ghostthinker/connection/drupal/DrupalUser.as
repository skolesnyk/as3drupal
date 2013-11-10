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
		private var _realname:String;
		//more field should be added
		private var _domainIds:Array;
		
		public function DrupalUser( name:String = "anonymous" , uid:int = 0 , picture:String = "" , mail:String = "nomail@no.mail" ) 
		{
			this._name = name;
			this._uid = uid;
			this._mail = mail;
			this._picture = picture;
			this._roles = new Array();
			this._domainIds = new Array();
		}
		
		protected function addDomainId( domainId:int ) 
		{
			this._domainIds.push( domainId );
		}
		
		protected function addRole( role:DrupalRole ) 
		{
			this._roles.push( role );
		}
		
		public function get name():String {	return _name; }
		public function get uid():int  {	return _uid; }
		public function get mail():String {	return _mail; }
		public function get picture():String {	return _picture; }
		public function get roles():Array {	return _roles; }
		public function get domainIds():Array {	return _domainIds; }
		
		public function get realname():String 
		{
			if ( _realname) 
			{
				return _realname;
			}
			return name;
			
		}
		
		public function set realname(value:String):void 
		{
			_realname = value;
		}

	}
	
}