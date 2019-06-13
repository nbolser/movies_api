# frozen_string_literal: true

class MoviesSearchQuery
  def initialize(params, conn)
    @params = params
    @conn = conn
  end

  def all
    filter_params.each do |key, value|
      @results = conn[
        <<-SQL
          SELECT imdbId, title, genres, releaseDate, budget
          FROM movies
          WHERE #{key} LIKE "%#{value}%"
          ORDER BY releaseDate #{sort_order}
        SQL
      ].all unless value.nil?
    end
    results
  end

  private

  attr_accessor :results
  attr_reader :params, :conn

  def filter_params
    params.slice(:genres, :releaseDate)
  end

  def sort_order
    params[:order] unless params[:releaseDate].nil?
  end
end
