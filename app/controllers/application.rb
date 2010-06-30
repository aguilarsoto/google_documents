# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
	DOCLIST_SCOPE = 'http://docs.google.com/feeds/'
	DOCLIST_FEED = DOCLIST_SCOPE + 'documents/private/full'
	DOCLIST_DISPLAY = DOCLIST_SCOPE + 'documents/private/expandAcl'

	DOCUMENT_DOC_TYPE = 'document'
	MINE_LABEL = 'mine'
 
    def setup_client
    @client = GData::Client::DocList.new({:authsub_scope => DOCLIST_SCOPE,
                                          :source => 'google_documents',
                                          :version => '1.0'})

     @client.clientlogin('name@gmail.com', 'pa$$word') 
     end

 
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c59cfc05700c5ff00dc490f5d74796cb'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
