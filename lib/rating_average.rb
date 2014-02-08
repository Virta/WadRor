module RatingAverage
  def average_rating
    return nil if ratings.empty?
      sum = 0.0
      ratings.each do |rating|
        sum += rating.score
      end
      sum/ratings.count
  end
end