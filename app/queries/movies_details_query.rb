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
    format_ratings
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
    return [] if movie_details.empty?
    @data = rating.each_with_object(movie_details[0]) do |rating, details|
      details.merge!(rating: rating[:rating]) if rating[:movieId] == details[:movieId]
      details.except!(:movieId)
    end
  end

  def format_budget
    return [] if data.nil?
    data.merge!(budget: number_to_currency(data[:budget]))
  end

  def format_ratings
    return [] if data.nil? # Added this guard after the fact to allow the test suite to run greem
    res = get_ombd_data(data[:imdbId])
    data.merge!(rating: { db: data[:rating], omdb: res["imdbRating"] }) if data[:imdbId] == res["imdbID"]
  end

  def get_ombd_data(imdb_id)
    res = RestClient.get("http://www.omdbapi.com/?apikey=ceb9bf8c&i=#{imdb_id}")
    JSON.parse(res.body)
  end
end
