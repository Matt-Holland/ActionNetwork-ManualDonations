class DonationsController < ApplicationController


def index

end



def create 

campaign_url = 'https://actionnetwork.org/api/v2/fundraising_pages/' + params[:campaign][:action_network_id] + '/donations'

donor_url = 'https://actionnetwork.org/api/v2/people/' + params[:person][:action_network_id]


 @response = RestClient::Request.new({
    method: :post,
    url: campaign_url,
    payload: {"identifiers":[ params[:campaign][:action_network_id]  ],"recipients":[{"display_name": params[:donation][:display_name] ,"amount": params[:donation][:amount] }],"_links":{"osdi:person":{"href":donor_url}}},
    headers: {'content_type' => :json, 'OSDI-API-Token' => '449ad9a708611ca4c91d99511ea3ff40'}
  }).execute do |response, request, result|
    case response.code
    when 400
      [ :error, JSON.parse(response.to_str) ]
    when 200
      [ :success, JSON.parse(response.to_str) ]
    else
      fail "Invalid response #{response.to_str} received."
    end
  end

end


end
