# frozen_string_literal: true

require_relative '../../config/application.rb'

class Movie
  extend DatabaseHelper

  connect('./db/movies.db')

  def self.all
    MoviesQuery.new(@db).all
  end

  def self.find_details(id)
    MoviesDetailsQuery.new(id, @db).all
  end

  def self.search(params)
    MoviesSearchQuery.new(params, @db).all
  end
end
