package com.ghostthinker.connection.drupal 
{
	/**
	 * ...
	 * @author jm
	 */
	public class DrupalRole
	{
		private var _name:String;
		private var _roleId:int;
		
		public function DrupalRole( name:String , roleId:int ) 
		{
			_name = name;
			_roleId = roleId;
		}
		
		public function get name():String { return _name; }
		
		public function get roleId():int { return _roleId; }
		
	}

}