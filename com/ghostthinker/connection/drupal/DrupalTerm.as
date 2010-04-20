/**
 * $Id: DrupalTerm.as 241 2009-05-27 12:18:27Z metschjo $
 *
/*******************************************************************************
 * Copyright (c) 2007-2010
 * Ghostthinker GmbH <www.ghostthinker.com>
 *
 * All rights reserved.
 *
 * Contributors:
 *    Stefan Hörterer, Johannes Metscer
 *******************************************************************************/

package com.ghostthinker.connection.drupal 
{
	
	public class DrupalTerm
	{
		private var _depth:int;
		private var _description:String;
		private var _language:String;
		private var _name:String;
		private var _tid:int;
		private var _trid:int;
		private var _vid:int;
		private var _weight:int;
		private var _parent:DrupalTerm;
		private var _children:Array;
		private var _parentTid:int;
		
		public function DrupalTerm( depth:int , description:String , language:String , name:String , 
		                            tid:int , trid:int , vid:int , weight:int ) 
		{
			this._depth       = depth;
			this._description = description;
			this._language    = language;
			this._name        = name;	
			this._tid         = tid;
			this._trid        = trid;
			this._vid         = vid;
			this._weight      = weight;
			this._children    = new Array();
			this._parentTid   = 0;
		}
		
		public static function fromResponse(response:Object):DrupalTerm {
			
		}
		
		public function get depth():int { return _depth; }
		
		public function set depth(value:int):void 
		{
			_depth = value;
		}
		
		public function get description():String { return _description; }
		
		public function set description(value:String):void 
		{
			_description = value;
		}
		
		public function get language():String { return _language; }
		
		public function set language(value:String):void 
		{
			_language = value;
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get tid():int { return _tid; }
		
		public function set tid(value:int):void 
		{
			_tid = value;
		}
		
		public function get trid():int { return _trid; }
		
		public function set trid(value:int):void 
		{
			_trid = value;
		}
		
		public function get vid():int { return _vid; }
		
		public function set vid(value:int):void 
		{
			_vid = value;
		}
		
		public function get weight():int { return _weight; }
		
		public function set weight(value:int):void 
		{
			_weight = value;
		}
		
		public function get parent():DrupalTerm { return _parent; }
		
		public function set parent(value:DrupalTerm):void 
		{
			_parent = value;
		}
		
		public function get children():Array { return _children; }
		
		public function get parentTid():int { return _parentTid; }
		
		public function set parentTid(value:int):void 
		{
			_parentTid = value;
		}
		
		public function addChild( child:DrupalTerm ):void
		{
			_children.push( child );
		}
		
		public function isParent( potentialParent:DrupalTerm ):Boolean
		{
			if ( this._parentTid == potentialParent.tid ) {
				return true;
			}
			return false;
		}
		
		public function checkAndAssignRelations( potentialParent:DrupalTerm ):void
		{
			if ( isParent( potentialParent ) ) {
				potentialParent.addChild( this );
				this._parent = potentialParent;
			}
		}
		
		public function get rawTerm():Object
		{
			var rawTerm:Object  = new Object();
			
			rawTerm.depth       = _depth.toString();
			rawTerm.description = _description;
			rawTerm.language    = _language;
			rawTerm.name        = _name;
			rawTerm.tid         = _tid.toString();
			rawTerm.trid        = _trid.toString();
			rawTerm.vid         = _vid.toString();
			rawTerm.weight      = _weight.toString();
			
			
			return rawTerm;
		}

	}
	
}