class DonorsController < ApplicationController

   def index

    # show the search form
   end




    def search
    
        # should receive an action_network: id for a campaign in params, and throw an error if not

        # go get all the data on the fundraising_page we care about, and pass it on to the next view

        #     campaign_url = "https://actionnetwork.org/api/v2/fundraising_pages/" + params[:campaign][:action_network_id] #?filter=origin_system%20eq%20%27Mattholland.com%27"
        
        #     campaign_response = RestClient.get(campaign_url, headers={'content_type' => :json, 'OSDI-API-Token' => '449ad9a708611ca4c91d99511ea3ff40'})
        #     @campaign_object = JSON.parse(campaign_response, object_class: OpenStruct)


        
    
        if params[:person] then
            filter_array = Array.new
            params[:person].keys.each do |param_key| 
                unless params[:person][param_key].blank?
                    filter_array.push(param_key + '%20eq%27' + params[:person][param_key] + '%27')
                end
            end
            filter_string = filter_array.join('%20and%20')
            
            person_url = 'https://actionnetwork.org/api/v2/people/?filter=' + filter_string 

            @person_response = RestClient.get(person_url, headers={'content_type' => :json, 'OSDI-API-Token' => '449ad9a708611ca4c91d99511ea3ff40'})

            @response_hash = JSON.parse(@person_response)

            @donors_array = @response_hash['_embedded']['osdi:people']

            render :show
        end

    end


    def show
        
                
        
                # how do I just show the empty form if we don't have params? I guess only do the submittal of
                # the api search if we already have parameters to work with...
        
                filter_array = Array.new
        
                params[:person].keys.each do |param_key| 
                    unless params[:person][param_key].blank?
                        filter_array.push(param_key + '%20eq%27' + params[:person][param_key] + '%27')
                    end
                end
                filter_string = filter_array.join('%20and%20')
                
                url = 'https://actionnetwork.org/api/v2/people/?filter=' + filter_string 
        
                @response = RestClient.get(url, headers={'content_type' => :json,
                    'OSDI-API-Token' => @keys['ruckus_api']})
        
                @response_hash = JSON.parse(@response)
        
                @donors_array = @response_hash['_embedded']['osdi:people']
                  
            end
    
end

