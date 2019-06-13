# frozen_string_literal: true

require 'spec_helper'

describe Rating, type: :model do
  let(:call) { Rating.find_ratings(31) }

  before do
    Rating.connect('./db/ratings_test.db')
  end

  describe '.find_ratings(id)' do
    it "it returns an array of movies" do
      expect(call.count).to(eq(1))
    end

    it "it returns an array of movies" do
      expect(call.first.keys)
        .to(match_array([:movieId, :rating]))
    end
  end
end
