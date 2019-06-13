# frozen_string_literal: true

require 'spec_helper'

describe Movie, type: :model do
  let(:call) { Movie.all }

  before do
    Movie.connect('./db/movies_test.db')
  end

  describe '.all' do
    it 'it returns an array of movies' do
      expect(call.count).to(eq(25))
    end

    it 'it returns an array of movies' do
      expect(call.first.keys)
        .to(match_array([:imdbId, :title, :genres, :releaseDate, :budget]))
    end
  end

  describe '.find_details' do
    let(:movie_ids) { Rating.find_ratings(1421) }
    let(:call) { Movie.find_details(1421) }

    it 'it returns an array of movies' do
      expect(call).to(be_kind_of(Hash))
    end

    it 'it returns an array of movies' do
      expect(call.keys)
        .to(
          match_array(
            [:imdbId, :title, :overview, :releaseDate, :budget, :runtime, :rating, :genres, :language,
             :productionCompanies]
          )
        )
    end
  end

  describe '.search' do
    let(:call) { Movie.search(params) }
    let(:params) { { releaseDate: '2006' } }

    it 'it returns an array of movies' do
      expect(call.count).to(eq(5))
    end
  end
end
