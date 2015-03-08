require 'uri'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  def authorize
    if not_logged_in?
      redirect_to root_url, notice: "Please log in"
    end
  end

  def not_logged_in?
    session[:user_id].nil?
  end

  def current_user
    User.find(session[:user_id])
  end

  #gets ip of client
  def get_ip
    #if client is "local=::1" (running on localhost) then use a default IP address, otherwise use remote
    if request.remote_ip == "::1"
      return "164.82.9.60" #REPLACE WITH BETTER DEFAULT IP
    end
    return request.remote_ip
  end

  #use freegeoip.net API to get the lat lon associated with an IP address using it in trails controller and main
  def get_lat_lon(ip)
    #gets JSON from site
    response = HTTParty.get("https://freegeoip.net/json/" + ip)
    return {:lat => response["latitude"], :lon => response["longitude"]}
  end

  def geocode(location)
    #response = HTTParty.get("http://open.mapquestapi.com/geocoding/v1/address?key=Fmjtd%7Cluu8290ynq%2Cbn%3Do5-9470h6&callback=renderOptions&inFormat=kvp&outFormat=json&location="+location);
    response = HTTParty.get(URI.escape("http://nominatim.openstreetmap.org/search/" + location + "?format=json&addressdetails=1&limit=1&polygon_svg=1"))
    return {:lat => response[0]["lat"], :lon => response[0]["lon"] }
  end
end
