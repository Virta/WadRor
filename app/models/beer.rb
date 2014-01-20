class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

include RatingAverage

  def to_s
    "#{(Brewery.find_by id:brewery_id).name}: #{name}"
  end

end