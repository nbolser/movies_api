# frozen_string_literal: true

require 'spec_helper'

describe MoviesQuery, type: :query do
  let(:conn) { Movie.connect('./db/movies_test.db') }
  let(:call) { MoviesQuery.new(conn).all }

  describe '.all' do
    it "it returns an array of movies that match criteria" do
      expect(call.first.keys).to(match_array(
        [:imdbId, :title, :genres, :releaseDate, :budget]
      ))
    end

    it "it returns budget in dollars" do
      expect(call.first[:budget]).to(eq('$90,000,000.00'))
    end
  end
end
