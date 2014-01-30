class User < ActiveRecord::Base
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
  has_secure_password

  include RatingAverage

  validates :username,  uniqueness: true,
                        length:{  minimum: 3,
                                  maximum: 15 }

  validates :password, :format => { :with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{4,}\z/,
                                    :message => "Password must contain at least 4 characters with one upper case and one numeric." }

end