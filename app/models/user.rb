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

  def favourite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favourite_style
    return nil if ratings.empty?
    styles_interrogate(["Weizen", "Lager", "Pale ale", "IPA", "Porter"])
  end

  def styles_interrogate(styles)
    highest = 0.0
    style = ''
    styles.each do |s|
      if (candidate = average_rating_for_style(s)) > highest
        highest = candidate
        style = s
      end
    end
    style
  end

  def average_rating_for_style(style)
    ratings = Rating.all.select{ |r| r.beer.style == style }
    return 0.0 if ratings.empty?
    average(ratings)
  end

  def average(ratings)
    sum = 0.0
    ratings.each do |r|
      sum += r.score
    end
    sum/ratings.count
  end

end