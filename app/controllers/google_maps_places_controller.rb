class GoogleMapsPlacesController < ApplicationController
  def index
    if params[:q].present?
      response = RestClient.get('https://maps.googleapis.com/maps/api/place/textsearch/json', params: {
        query: params[:q],
        key: ENV['GOOGLE_MAPS_API_KEY']
      })
      results = JSON.parse(response.body)['results']
      @places = results.map { |result| { id: result['place_id'], name: result['name'] } }
    else
      @places = []
    end
    render json: @places
  end
end
