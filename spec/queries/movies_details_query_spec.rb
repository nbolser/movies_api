# frozen_string_literal: true

require 'spec_helper'

describe MoviesDetailsQuery, type: :query do
  let(:conn) { Movie.connect('./db/movies_test.db') }
  let(:call) { MoviesDetailsQuery.new(1421, conn).all }

  describe '.all' do
    it "it returns an array of movies that match criteria" do
      # Added mock / stub to get test suite passing as well
      res = double('res', body: "{\"imdbRating\":\"7.5\",\"imdbID\":\"tt0076155\"}")
      allow(RestClient).to(receive(:get).and_return(res))

      expect(call.keys).to(match_array(
        [:imdbId, :title, :overview, :releaseDate, :budget, :runtime, :genres, :language, :productionCompanies, :rating]
      ))
    end
  end
end
