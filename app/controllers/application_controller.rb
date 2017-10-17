class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :get_keys
  def get_keys
    @keys = YAML::load_file("app/apikeys.yaml")
  end
  

end
