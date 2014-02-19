class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, length: { minimum: 3 ,
                              maximum: 30}
  validates :founded, numericality: { greater_than_or_equal_to: 1900,
                                      less_than_or_equal_to: Date.today.year }
  validates :city, length: { minimum: 3,
                              maximum: 20 }

  def members(confirmation)
    memberships.all.select{ |m| m.confirmed==confirmation}
  end

  def to_s
    "#{name}, #{city}"
  end
end
