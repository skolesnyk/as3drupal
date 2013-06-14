package com.ghostthinker.connection.drupal.util 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class DrupalVocabulary
	{
		private var _vid:int;
		private var _name:String;
		private var _language:String;
		private var _description:String;
		private var _help:int;
		private var _relations:Boolean;
		private var _hierarchy :Boolean;
		private var _multiple :Boolean;
		private var _required:Boolean;
		private var _tags:Boolean;
		private var _language:String;
		
		protected var _terms:Dictionary;
		
		public function DrupalVocabulary(vid:int) 
		{
			_vid = vid;
		}
		
	}

}