class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << rating
      redirect_to users_path current_user
    else
      @beers = Beer.all
      render :new
    end

  end

  def destroy
    Rating.find(params[:id]).destroy
    redirect_to :back
  end

end