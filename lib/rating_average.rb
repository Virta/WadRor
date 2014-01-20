module RatingAverage
  def average_rating
    if ratings.count > 0
      sum = 0.0
      ratings.each do |rating|
        sum += rating.score
      end
      sum/ratings.count
    end

  end
end