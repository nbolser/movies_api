# frozen_string_literal: true

require_relative '../../config/application.rb'

class Movie
  extend DatabaseHelper

  connect('./db/movies.db')

  def self.all
    @db[
      <<-SQL
        SELECT imdbId, title, genres, releaseDate, budget
        FROM movies
      SQL
    ].all
  end

  def self.find_details(id)
    MoviesDetailsQuery.all(id, @db)
  end

  def self.search(params)
    MoviesSearchQuery.all(params, @db)
  end
end
