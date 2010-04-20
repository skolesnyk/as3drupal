package com.ghostthinker.connection.drupal.util 
{
	
	/**
	 * ...
	 * @author Johannes Metscher
	 */
	public class DrupalFieldTypes 
	{
		
		public static var TEXT:String           = "text";
		public static var DATE:String           = "date";
		public static var NODE_REFERENCE:String = "node_reference";
		public static var INT:String            = "int";	
		public static var RATING:String         = "rating";
		
		public static function getValue( rawField:Object , fieldType:String  ):Object
		{
			switch( fieldType ) {
				case TEXT:
					return rawField[0].value;
				case NODE_REFERENCE:
					var nodeRefs:Array = new Array();
					if ( rawField is Array ) {
						for each( var nodeRef in rawField) { 
							nodeRefs.push( nodeRef.nid );
						}
					}
					return nodeRefs;
				case INT:
					return int( rawField[0].value );
			}
		}
	}
	
}