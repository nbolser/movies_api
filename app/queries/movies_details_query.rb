# frozen_string_literal: true

class MoviesDetailsQuery
  include FormatHelper

  def initialize(id, conn)
    @id = id
    @conn = conn
  end

  def all
    merge_movie_ratings
    format_budget
  end

  private

  attr_reader :id, :conn, :data

  def rating
    Rating.find_ratings(id)
  end

  def movie_details
    conn[:movies]
      .where(movieId: id)
      .select(:movieId, :imdbId, :title, :overview, :releaseDate, :budget,
          :runtime, :genres, :language, :productionCompanies).all
  end

  def merge_movie_ratings
    @data = rating.each_with_object(movie_details[0]) do |rating, details|
      details.merge!(rating: rating[:rating]) if rating[:movieId] == details[:movieId]
      details.except!(:movieId)
    end
  end

  def format_budget
    @data.merge!(budget: number_to_currency(@data[:budget]))
  end
end
