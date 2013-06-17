/*******************************************************************************
 * @file structerd object for drupal service 7.x-3.x
 * Copyright (c) 2007-2009
 * Ghostthinker GmbH <www.ghostthinker.com>
 *
 * All rights reserved.
 *
 * Contributors:
 *    Stefan Hörterer, Johannes Metscer
 *******************************************************************************/

package com.ghostthinker.connection.drupal
{
	import flash.events.EventDispatcher;

	public class DrupalComment extends EventDispatcher
	{
		protected var _entity:Object;
		
		public function DrupalComment()
		{
			super();
		}
		public function get entity():Object
		{
			return this._entity;
		}
		
		public function set entity(value:Object):void 
		{
			_entity = value;
		}
		
		/**
		 * Create an object of style *.und[0].value
		 * @param	obj
		 * @param	lang
		 * @return
		 */
		protected function createFieldValue( obj:Object, lang:String="und" ):Object
		{
			var field:Object = new Object();
			field[lang] = new Array( {value: { value: obj.toString() } } );
			return field;
		}
		/*
		
		protected function createFieldParMultiple( vals:Array ):Array
		{
			var refs:Array = new Array();
			for each(var val:Object in vals) {
					refs.push( { value: { value: val.toString() } } );
			}
			return refs;
		}
		
		protected function createNodeRefPar( obj:Object ):Array
		{
			return new Array( {nid: obj.toString()} );
		}
		
		protected function createNodeRefParMultiple( nids:Array ):Array
		{
			var refs:Array = new Array();
			for each(var nid:Object in nids) {
					refs.push( {nid: nid.toString()});
			}
			return refs;
		}
		
		protected function createUserRefPar( obj:Object ):Array
		{
			return new Array( {uid: obj.toString()} );
		}
		
		/**
		 * createTaxonomy
		 * @param	terms is an array containing DrupalTerms
		 * @return  object containing the terms drupal service preformatted
		 //* /

		protected function createTaxonomy( terms:Array  ):Object
		{	
			var taxonomy = new Object();

			for each( var term:DrupalTerm in terms ) 
			{
				if ( taxonomy[ term.vid  ] == null ) {
					taxonomy[ term.vid  ] = new Object();
				}
				taxonomy[ term.vid  ][ term.tid ] = term.tid;
			}
			return taxonomy;
		}
		*/
	}
}