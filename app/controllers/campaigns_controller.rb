class CampaignsController < ApplicationController

  

  def index
    # show all the available fundraising pages, which we call "campaigns"

    url = "https://actionnetwork.org/api/v2/fundraising_pages?filter=origin_system%20eq%20%27Ruckus%20Manual%20Input%27"
  
    # @keys is created in application_controller, by reading a yaml file which is not stored in git
    response = RestClient.get(url, headers={'content_type' => :json, 'OSDI-API-Token' =>  @keys['ruckus_api']   })
    @response_hash = JSON.parse(response)
    # @response_object = JSON.parse(@response, object_class: OpenStruct)
    campaigns_array = @response_hash['_embedded']['osdi:fundraising_pages']    
    @campaign_object_array  = Array.new
    campaigns_array.each do |campaign_hash|
      new_campaign_object = OpenStruct.new(campaign_hash)
      @campaign_object_array.push(new_campaign_object)
    end

    @total_records = @response_hash['total_records']
      
  end

  def search
    # retrieve the details of one selected campaign, make a custom object with just the good parts and store in the session

    if params[:campaign] then
      campaign_action_network_id = params[:campaign][:action_network_id]
    else
      campaign_action_network_id = session[:campaign_hash]['id']
    end


    campaign_url = "https://actionnetwork.org/api/v2/fundraising_pages/" + campaign_action_network_id
    
    campaign_response = RestClient.get(campaign_url, headers={'content_type' => :json, 'OSDI-API-Token' => @keys['ruckus_api'] })
    @campaign_object = JSON.parse(campaign_response, object_class: OpenStruct)

    campaign_action_network_id = 0
     @campaign_object.identifiers.each do |campaign_id| 
       if campaign_id.start_with?("action_network:") then 
        campaign_id.slice!('action_network:') 
        campaign_action_network_id = campaign_id
       end 
     end 
    
    session[:campaign_hash] = { 'id' => campaign_action_network_id, 
                                'title' => @campaign_object.title,
                                'origin_system' => @campaign_object.origin_system 
                              }
    

    render "donors/search"

  end



end
