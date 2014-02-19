class Brewery < ActiveRecord::Base
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  include RatingAverage

  validates :name, length: { minimum: 3}
  validates :year, numericality: {  greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: Date.today.year }

  scope :active, -> { where active: true}
  scope :inactive, -> {where active: [nil, false]}

  def self.best_breweries
    all_rated_breweries = Brewery.all.select{ |b| b.ratings.count>0 }
    all_rated_breweries.sort_by{ |b| b.average_rating }.reverse!
  end

  #def average_rating
  #  if ratings.count > 0
  #    sum = 0.0
  #    ratings.each do |rating|
  #      sum += rating.score
  #    end
  #    sum/ratings.count
  #  end
  #
  #end

end
