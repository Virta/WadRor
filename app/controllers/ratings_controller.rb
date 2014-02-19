class RatingsController < ApplicationController
  before_action :enforce_signin, except: [:index, :show]

  def index
    @recent_ratings = Rating.recent
    @ratings_count = Rating.all.count
    @best_beers = Beer.best_beers.first(3)
    @best_breweries = Brewery.best_breweries.first(3)
    @active_users = User.most_active_users.first(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end

  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

end