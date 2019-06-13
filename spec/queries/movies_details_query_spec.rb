# frozen_string_literal: true

require 'spec_helper'

describe MoviesDetailsQuery, type: :query do
  let(:conn) { Movie.connect('./db/movies_test.db') }
  let(:call) { MoviesDetailsQuery.all(1421, conn) }

  describe '.all' do
    it "it returns an array of movies that match criteria" do
      expect(call.keys).to(match_array(
        [:imdbId, :title, :overview, :releaseDate, :budget, :runtime, :genres, :language, :productionCompanies, :rating]
      ))
    end
  end
end
