class RatingsController < ApplicationController
  before_action :enforce_signin, except: [:index, :show]

  def index
    Rails.cache.write('recent-ratings', Rating.recent) unless cached_and_valid 'recent-ratings'
    @recent_ratings = Rails.cache.read 'recent-ratings'

    Rails.cache.write('ratings-count', Rating.all.count) unless cached_and_valid 'ratings-count'
    @ratings_count = Rails.cache.read 'ratings-count'

    Rails.cache.write('top-stats',
                      [ Beer.best_beers.first(3),
                        Brewery.best_breweries.first(3),
                        Style.best_styles.first(3)
                      ] ) unless cached_and_valid 'top-stats'

    @best_beers = Rails.cache.read('top-stats')[0]

    @best_breweries = Rails.cache.read('top-stats')[1]

    @best_styles = Rails.cache.read('top-stats')[2]

    Rails.cache.write('active-users', User.most_active_users.first(3)) unless cached_and_valid 'active-users'
    @active_users = Rails.cache.read 'active-users'
  end

  def cached_and_valid(cache_key)
    Rails.cache.exist?(cache_key)
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