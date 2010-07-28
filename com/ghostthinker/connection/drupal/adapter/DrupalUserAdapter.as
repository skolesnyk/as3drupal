package com.ghostthinker.connection.drupal.adapter 
{
	import com.ghostthinker.connection.drupal.DrupalRole;
	import com.ghostthinker.connection.drupal.DrupalUser;
	
	/**
	 * ...
	 * @author jm
	 */
	public class DrupalUserAdapter extends DrupalUser
	{
		
		public function DrupalUserAdapter( raw:Object ) 
		{
			try
			{
				trace( raw );
					
				var __name    =  raw.name ;
				var __uid     = int(raw.uid);
				var __mail    = raw.mail;
				var __picture = raw.picture;
				
				super(  __name ,
						__uid ,
						__picture ,
						__mail
					);
			}
			catch(e)
			{
				throw new Error("invalid user");
				trace("ERROR CREATING USER FROM XMLRPC RESPONSE");
			}
			
			if ( raw.domain_user )
			{
				assignDomainIds(  raw.domain_user );
			}
			
			if ( raw.roles )
			{
				assignRoles( raw.roles );
			}
		}
		
		function assignDomainIds( domainIds ):void
		{
			for ( var domainId in domainIds )
			{
				this.addDomainId( int(domainId) );
			}
		}
		
		function assignRoles( roles ):void
		{
			for ( var role in roles )
			{
				this.addRole( new DrupalRole( roles[role] , role ) );
				//this._domainIds.push( int(domainId) );
				//this.addDomainId( int(domainId) );
			}
		}
		
	}

}