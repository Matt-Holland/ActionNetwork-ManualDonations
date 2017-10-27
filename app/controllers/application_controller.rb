class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :get_keys
  def get_keys
    @keys = {'ruckus_api' => ENV['RUCKUS_API_KEY'] }
  end
  
  before_action :authenticate
  
 # protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username = ENV['RUCKUS_USER'] && password = ENV['RUCKUS_PASS']
    end
  end


end
