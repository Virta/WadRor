class PlacesController < ApplicationController

  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      session[:city] = nil
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:city] = params[:city]
      render :index
    end
  end

  def show
    places = BeermappingApi.places_in(session[:city])
    @place = places.select{ |p| p.id == params[:id] }.first

    #places.each do |p|
    #  @place = p if p.id == params[:id]
    #end

    unless @place
      redirect_to places_path, notice: "No information on that place"
    end
  end
end