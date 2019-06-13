# frozen_string_literal: true

class MoviesQuery
  include FormatHelper

  def initialize(conn)
    @conn = conn
  end

  def all
    collect_movies
    format_budget
  end

  private

  attr_reader :conn, :data

  def collect_movies
    @data = conn[
      <<-SQL
        SELECT imdbId, title, genres, releaseDate, budget
        FROM movies
      SQL
    ].all
  end

  def format_budget
    @data.each do |movie|
      movie.merge!(budget: number_to_currency(movie[:budget]))
    end
    @data
  end
end
