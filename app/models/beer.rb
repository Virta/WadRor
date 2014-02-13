class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  has_many :all_raters, through: :ratings, source: :user
  belongs_to :style

  include RatingAverage

  validates :name, length: { minimum: 3 }
  validates :old_style, length: { minimum: 2 }

  def to_s
    "#{(Brewery.find_by id:brewery_id).name}: #{name}"
  end

end