class Document < ActiveRecord::Base


def self.check_cache(uri)
   require 'rexml/document'
	document = Document.find(:first, :conditions => [ "url = ?", uri ])
	if (document)
		if (document.updated_at < 2.hours.ago)
			document.destroy
		else
			feed = REXML::Document.new(document.cache)
		end
	end
	return feed
end


end
