# frozen_string_literal: true

require 'spec_helper'

describe MoviesSearchQuery, type: :query do
  let(:conn) { Movie.connect('./db/movies_test.db') }
  let(:call) { MoviesSearchQuery.new(params, conn).all }

  describe '.all' do
    let(:params) { { genres: 'Action' } }

    it "it returns an array of movies that match criteria" do
      expect(call.count).to(eq(7))
    end

    it "it returns specified attributes" do
      expect(call.first.keys)
        .to(match_array([:imdbId, :title, :genres, :releaseDate, :budget]))
    end

    it "it returns specified attributes data" do
      expect(call.first.values).to(match_array(
        ["tt0104693", "Laws of Gravity", "[{\"id\": 28, \"name\": \"Action\"}, {\"id\": 18, \"name\": \"Drama\"}]",
         "1992-03-21", 0]
      ))
    end

    context 'searching by year' do
      let(:params) { { releaseDate: '1994' } }

      it "it returns an array of movies that match search criteria" do
        expect(call.count).to(eq(1))
      end
    end
  end
end
