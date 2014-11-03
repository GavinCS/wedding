class AccommodationsController < ApplicationController

  def index
    @accommodations = Accommodation.all
  end

  def show
    @accommodation = Accommodation.find(params[:id])
    @marker = Gmaps4rails.build_markers(@accommodation) do |accommodation, marker|
      marker.lat accommodation.latitude
      marker.lng accommodation.longitude
    end
    @image = @accommodation.image.map.url
  end

end
