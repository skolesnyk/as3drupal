/**
 * $Id: TaxonomyService.as 241 2009-05-27 12:18:27Z metschjo $
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

package com.ghostthinker.connection.drupal.service 
{
	import com.ghostthinker.connection.drupal.event.ServiceEvent;
	import com.ghostthinker.connection.drupal.server.IServer;
	
	import flash.events.Event;
	
	public class TaxonomyService extends AbstractService
	{
		
		public static const EVENT_TAXONOMY_TREE_LOADED:String = "taxonomy.onTaxonomyTreeLoaded";
		public static const ERROR_VIEW_NOT_FOUND:String       =	"View does not exist.";
		public static const SERVICE_CALL_GET_TREE:String      =	"taxonomy.getTree";
		
		public function TaxonomyService( server:IServer)
		{
			super( server );
			this.addError(ERROR_VIEW_NOT_FOUND);
		}
		
		/**
		 * Load a taxonomy tree from Drupal
		 * @param vid A vocabulary id.
		 */
		public function getTree( vid:int , parentTid:int = 0 ,  maxDepth:int = -1 ):void
		{
			var sc:ServiceCall = new ServiceCall( SERVICE_CALL_GET_TREE);
			sc.addParam( vid       , ServiceCall.TYPE_STRING);
			//sc.addParam( parentTid , ServiceCall.TYPE_STRING);
			
			if( maxDepth >= 0 ){
				sc.addParam( maxDepth, ServiceCall.TYPE_STRING);
			}
			
			this._server.call( sc , onLoaded );
		}
		
		/**
		 * Event which is triggered by the response to taxonomy.getTree
		 * @param	evt
		 */
		public function onLoaded( evt:Event ):void
		{
			//TODO: catch errors
			this.dispatchEvent(new ServiceEvent(evt.target.getResponse(),TaxonomyService.EVENT_TAXONOMY_TREE_LOADED));
		}
		
	}
	
}