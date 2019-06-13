# frozen_string_literal: true

require 'spec_helper'

describe Movie, type: :model do
  let(:call) { Movie.all }

  before do
    Movie.connect('./db/movies_test.db')
  end

  describe '.all' do
    it "it returns an array of movies" do
      expect(call.count).to(eq(25))
    end

    it "it returns an array of movies" do
      expect(call.first.keys)
        .to(match_array([:imdbId, :title, :genres, :releaseDate, :budget]))
    end
  end

  describe '.search' do
    it "it returns an array of movies" do
      expect(Movie.all.count).to(eq(25))
    end
  end
end
