# frozen_string_literal: true

class MoviesDetailsQuery
  def self.all(id, conn)
    new(id, conn).all
  end

  def initialize(id, conn)
    @id = id
    @conn = conn
  end

  def all
    rating.each_with_object(movie_details[0]) do |rating, details|
      details.merge!(rating: rating[:rating]) if rating[:movieId] == details[:movieId]
      details.except!(:movieId)
    end
  end

  private

  attr_reader :id, :conn

  def rating
    @_ratings = Rating.find_ratings(id)
  end

  def movie_details
    @_details = conn[
      <<-SQL
        SELECT movieId, imdbId, title, overview, releaseDate, budget, runtime, genres, language, productionCompanies
        FROM movies
        WHERE movieId = #{id}
      SQL
    ].all
  end
end
