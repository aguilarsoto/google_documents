class DocumentsController < ApplicationController
  
  # GET /documents
  # GET /documents.xml
  def index 

    @documents = Array.new # = Document.find(:all)
    
     options = [DOCUMENT_DOC_TYPE, MINE_LABEL]
    
      uri = DOCLIST_FEED + "/-/#{options.join('/')}"
	  feed = Document.check_cache(uri)
	  if (! feed)
		setup_client()
		feed = @client.get(uri).to_xml
		Document.create(:url => uri, :cache => feed.to_s)
	  end
	  
      feed.root.elements.each('entry') do |entry|
      
      id = entry.elements['id'].text
      id.gsub!(DOCLIST_FEED+'/', '')

      element = Hash.new
	  element = { :title => entry.elements['title'].text,
				:type => entry.elements['category'].attribute('label').value,
				:updated => entry.elements['updated'].text,
				:id => id
				}
	entry.elements.each('link') do |link|
    element[link.attribute('rel').value] = link.attribute('href').value
    end
    @documents << element
    
end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
      format.json do 
		response.content_type = Mime::JSON
		render :text=>@documents.to_json
	  end 
    end
  end

  # GET /documents/1
  # GET /documents/1.xml
  def show
     uri = "#{DOCLIST_DISPLAY}/#{params[:id]}"
     feed = Document.check_cache(uri)
     if (! feed)
		setup_client()
		feed = @client.get(uri).to_xml
		Document.create(:url => uri, :cache => feed.to_s)
	 end
    
     @document = Hash.new
	 @document = { :title => feed.root.elements['title'].text,
				:type => feed.root.elements['category'].attribute('label').value,
				:updated => feed.root.elements['updated'].text,
				:id => id
				}
	 feed.root.elements.each('link') do |link|
	 @document[link.attribute('rel').value] = link.attribute('href').value
	end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
      format.json do 
		response.content_type = Mime::JSON
		render :text=>@document.to_json
	  end
    end
  end

  # GET /documents/new
  # GET /documents/new.xml
  def new

    respond_to do |format|
      format.html {render :nothing => true, :status => 204}
      format.xml  {render :nothing => true, :status => 204}
      format.json {render :nothing => true, :status => 204}
    end
  end

  # GET /documents/1/edit
  def edit
      format.html {render :nothing => true, :status => 204}
      format.xml  {render :nothing => true, :status => 204}
      format.json {render :nothing => true, :status => 204}    
  end

  # POST /documents
  # POST /documents.xml
  def create

    respond_to do |format|
      format.html {render :nothing => true, :status => 204}
      format.xml  {render :nothing => true, :status => 204}
      format.json {render :nothing => true, :status => 204}
    end

  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
    respond_to do |format|
      format.html {render :nothing => true, :status => 204}
      format.xml  {render :nothing => true, :status => 204}
      format.json {render :nothing => true, :status => 204}
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.xml
  def destroy
    respond_to do |format|
      format.html {render :nothing => true, :status => 204}
      format.xml  {render :nothing => true, :status => 204}
      format.json {render :nothing => true, :status => 204}
    end
end
end
