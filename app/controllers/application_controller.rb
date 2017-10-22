class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :get_keys
  def get_keys
    @keys = {'ruckus_api' => ENV['RUCKUS_API_KEY'] }
  end
  

end
