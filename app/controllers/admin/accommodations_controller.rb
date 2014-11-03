class Admin::AccommodationsController < ApplicationController
  before_filter :confirm_admin_logged_in

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

  def new
    @accommodation = Accommodation.new
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    if @accommodation.save
      redirect_to admin_accommodations_path, :notice => "Successfully created accommodation."
    else
      render :action => 'new'
    end
  end

  def edit
    @accommodation = Accommodation.find(params[:id])
  end

  def update
    @accommodation = Accommodation.find(params[:id])
    if @accommodation.update_attributes(accommodation_params)
      redirect_to admin_accommodation_path(@accommodation), :notice  => "Successfully updated accommodation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @accommodation = Accommodation.find(params[:id])
    @accommodation.destroy
    redirect_to accommodations_url, :notice => "Successfully destroyed accommodation."
  end


  def accommodation_params
    params.require(:accommodation).permit(:name, :website, :email,:contact_number,:image, :address, :latitude ,:longitude)
  end

end
