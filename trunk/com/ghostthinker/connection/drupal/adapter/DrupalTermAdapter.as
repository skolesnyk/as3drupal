/**
 * $Id: DrupalTermAdapter.as 241 2009-05-27 12:18:27Z metschjo $
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


package com.ghostthinker.connection.drupal.adapter 
{
	import com.ghostthinker.connection.drupal.DrupalTerm;

	public class DrupalTermAdapter extends DrupalTerm
	{
		
		public function DrupalTermAdapter( rawnode:Object ) 
		{	
			try
			{
				/* Assigns*/
				var __depth       = int( rawnode.depth );
				var __description = rawnode.description;
				var __language    = rawnode.language;
				var __name        = rawnode.name;
				var __tid         = int( rawnode.tid );
				var __trid        = int( rawnode.trid );
				var __vid         = int( rawnode.vid );
				var __weight      = int( rawnode.weight );
				
				
				super(  __depth ,
						__description ,
						__language ,
						__name ,
						__tid ,
						__trid ,
						__vid ,
						__weight 
					)
				
				// Assign parentTid
				if( rawnode.parents && rawnode.parents[0] )
				{
					var __parentTid   = int( rawnode.parents[0] );
					this.parentTid  = __parentTid;
				}

			}
			catch(e)
			{
				throw new Error("invalid term");
				trace("ERROR CREATING TERM FROM XMLRPC RESPONSE");
			}
		}
		
	}

}