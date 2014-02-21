class Beer < ActiveRecord::Base
  belongs_to :brewery, touch: true
  has_many :ratings, :dependent => :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  has_many :all_raters, through: :ratings, source: :user
  belongs_to :style

  include RatingAverage

  validates :name, length: { minimum: 3 }
  validates :style, presence: true

  def self.best_beers
    all_rated_beers = Beer.all.select{ |b| b.ratings.count>0 }
    all_rated_beers.sort_by{ |b| b.average_rating }.reverse!
  end

  def to_s
    "#{(Brewery.find_by id:brewery_id).name}: #{name}"
  end

end