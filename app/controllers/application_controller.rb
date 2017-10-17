class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :get_keys
  def get_keys
    @keys = {'ruckus_api' => '89c2ce51c53fb2d8323677621997812f'}     # YAML::load_file("app/apikeys.yaml")
  end
  

end
