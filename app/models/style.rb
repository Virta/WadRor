class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.best_styles
    all_rated_styles = Style.all.select{ |s| s.ratings.count >0}
    all_rated_styles.sort_by{ |s| s.average_rating }.reverse!
  end
end
