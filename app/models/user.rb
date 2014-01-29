class User < ActiveRecord::Base
  has_many :ratings
  has_many :beers, through: :ratings

  include RatingAverage

  validates :username,  uniqueness: true,
                        length:{  minimum: 3,
                                  maximum: 15 }

end