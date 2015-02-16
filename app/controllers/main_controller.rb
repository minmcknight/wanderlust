require 'httparty'
require 'nokogiri'
class MainController < ApplicationController
  skip_before_action :authorize
  
  def index
      # authkeys for everytrail api
      auth = {
         username: "75df33276084418f8882f59ba135cddd",
         password: "60ed78c6c060ee94"
       }

      if params[:search]
        search_query = params[:search]
        @coords=geocode(search_query)
      else 
        #instance variable is accessible from show page
        @user_ip = get_ip
        @coords = get_lat_lon(@user_ip)
      end  

      #queries everytrail api based on current location, gets xml string response. Httparty gem pulls data from remote data JSON data was not easy to read.
       @response = HTTParty.get("http://www.everytrail.com/api/index/search", :basic_auth => auth, :query => {:lat => @coords[:lat], 
                   :lon => @coords[:lon],
                   :proximity => 25, :limit => 11},
                   :format => :xml
                      )
       #parse xml string into an Nokogiri xml document(ruby objects) 
       doc = Nokogiri.XML(@response.body)
       #instance variable 
       @guides = []
       #find the guides nodelist in the search response
       @guides_xml = doc.xpath('//guides')
       @guides_xml.children.each do |guide_xml| 
         # go through the many child elements of <guide> children is method in the nokogiri nodelist object   
         guide = {}  
         guide_xml.children.each do |child| 
            if child.name == 'picture' 
                guide['pic_url'] = child.children[1].text 
            end 
            if child.name == 'url' 
                guide['url'] = child.text 
            end 
            if child.name == 'title' 
               guide['title'] = CGI.unescapeHTML(child.text) 
            end 
            if child.name == 'subtitle'
               guide['subtitle'] = CGI.unescapeHTML(child.text)
            end  
            if child.name == 'location' 
                guide['lat'] = child.attribute('lat')
                guide['lon'] = child.attribute('lon')
            end      
          end 
          @guides.push(guide)
       end   
  end



end

