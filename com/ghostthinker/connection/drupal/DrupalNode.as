﻿/**
 * $Id: DrupalNode.as 241 2009-05-27 12:18:27Z metschjo $
 *
/*******************************************************************************
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

	public class DrupalNode extends EventDispatcher
	{
		protected var _node:Object;
		
		public function DrupalNode()
		{
			super();
		}
		public function get node():Object
		{
			return this._node;
		}
		
		protected function createCCKFieldPar( obj:Object ):Array
		{
			return new Array( {value: { value: obj.toString() } } );
		}
		
		protected function createNodeRefPar( obj:Object ):Array
		{
			return new Array( {nid: obj.toString()} );
		}
		
		protected function createUserRefPar( obj:Object ):Array
		{
			return new Array( {uid: obj.toString()} );
		}
		
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
		
	}
}