class Brewery < ActiveRecord::Base
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  include RatingAverage

  validates :name, length: { minimum: 3}
  validates :year, numericality: {  greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: Date.today.year }

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
