# frozen_string_literal: true

require_relative '../../config/application.rb'

class Rating
  extend DatabaseHelper

  connect('./db/ratings.db')

  def self.find_ratings(id)
    @db[
      <<-SQL
        SELECT movieId, AVG(rating) as rating
        FROM ratings
        WHERE movieId = #{id}
      SQL
    ].all
  end
end
