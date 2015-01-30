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
    #if client is local (running on localhost) then use a default IP address
    if request.remote_ip == "::1"
      return "108.28.24.45" #REPLACE WITH BETTER DEFAULT IP
    end
    return request.remote_ip
  end

  #use freegeoip.net API to get the lat lon associated with an IP address
  def get_lat_lon(ip)
    #gets JSON from site
    response = HTTParty.get("https://freegeoip.net/json/" + ip)
    return {:lat => response["latitude"], :lon => response["longitude"]}
  end
end
