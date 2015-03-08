
class TrailsController < ApplicationController
  before_action :set_trail, only: [:show, :edit, :update, :destroy]


  def fix_html(input)
    temp = input.gsub(/&rsquo;|&lsquo;/,"'")
    return temp.gsub(/&mdash;/,"-")

  end
#respond_to :html, :xml, :json, :js
  # GET /trails
  # GET /trails.json
  def index
    @trails = Trail.all
  end

  # GET /trails/1
  # GET /trails/1.json
  def show
   #get trail out of our PostgreSQL database
   @trail = Trail.find(params[:id])

   @user_ip = get_ip
   @user_coords = get_lat_lon(@user_ip)
   puts @user_coords
   #authentication info for everytrail API
   auth = {
           username: "75df33276084418f8882f59ba135cddd",
           password: "60ed78c6c060ee94"
         }

  #create a new hash to hold the guide info
  @guide ={}
  begin
     #Query Everytrail API for URL of this trail
     #should return list of guides, with just one guide in it
     @response = HTTParty.get("http://www.everytrail.com/api/index/search", 
            :basic_auth => auth, 
            :query => {:q => @trail.name}, 
            :format => :xml,
            :timeout => 10)
   
     #parse XML string into XML object with Nokogiri
     doc = Nokogiri.XML(@response.body)
     #search XML object for the Guides element
     guides_xml = doc.xpath('//guides')
     
     #initialize variable to see if we found the guide yet
     found = false
     #loop over each guide in the list
     guides_xml.children.each do |guide_xml|  
       # go through the many child elements of <guide>   
       guide_xml.children.each do |child| 
          if child.name == 'picture' 
             @guide['pic_url'] = child.children[1].text 
          end 
          if child.name == 'subtitle' 
             @guide['subtitle'] = HTMLEntities.new.decode(fix_html(child.text))
          end 
          if child.name == 'overview'
            @guide['overview'] = HTMLEntities.new.decode(fix_html(child.text))
          end
          #when we find the item in the search results with the matching
          #url set the found var to true so that we can break out of the loop
          if child.name == 'url'
            if child.text == @trail.url
              found = true
            end
          end
       end
       if found
         break #break out of the loop because we found the right search result
       end

    end
  rescue Net::OpenTimeout, Net::ReadTimeout
     @error_msg = "EveryTrail API too slow at the moment...try again later"
  end 
end


  # GET /trails/new
  def new
    @trail = Trail.where(url: params[:url]).first
    if @trail.nil?
      @trail = Trail.new
      @trail.url = params[:url]
      @trail.name = params[:title]
      @trail.lon = params[:lon]
      @trail.lat = params[:lat]
      @trail.save
    end
    redirect_to @trail

  end

  # GET /trails/1/edit
  def edit
  end

  # POST /trails
  # POST /trails.json
  def create
    @trail = Trail.new(trail_params)

    respond_to do |format|
      if @trail.save
        format.html { redirect_to @trail, notice: 'Trail was successfully created.' }
        format.json { render :show, status: :created, location: @trail }
      else
        format.html { render :new }
        format.json { render json: @trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trails/1
  # PATCH/PUT /trails/1.json
  def update
    respond_to do |format|
      if @trail.update(trail_params)
        format.html { redirect_to @trail, notice: 'Trail was successfully updated.' }
        format.json { render :show, status: :ok, location: @trail }
      else
        format.html { render :edit }
        format.json { render json: @trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trails/1
  # DELETE /trails/1.json
  def destroy
    @trail.destroy
    respond_to do |format|
      format.html { redirect_to trails_url, notice: 'Trail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail
      @trail = Trail.find(params[:id])
    end
    

        def trail_params
        params.require(:trail).permit(:name, :url, :lat, :lon )
        end
end


