module RatingAverage extend ActiveSupport::Concern
  def average_rating
    return nil if ratings.empty?
      sum = 0.0
      count = 0
      ratings.each do |rating|
        sum += rating.score
        count+=1
      end
      sum/count
  end
end