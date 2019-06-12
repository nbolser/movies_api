# frozen_string_literal: true

require 'spec_helper'

describe API::Movies, type: :request do
  include Rack::Test::Methods

  def app
    API::Movies
  end

  context "API endpoints" do
    context "Invalid endpoint" do
      it "should not load pages that do not exist" do
        get '/foo'

        expect(last_response.status).to(eq(404))
      end
    end

    context "/movies" do
      it "returns a 200 OK" do
        get '/movies'

        expect(last_response.status).to(eq(200))
      end
    end

    context "/movies/:id/details" do
      it "returns a 200 OK" do
        get '/movies/1/details'

        expect(last_response.status).to(eq(200))
      end
    end

    context "/movies/search/:year" do
      it "returns a 200 OK" do
        get '/movies/search?year=1999'

        expect(last_response.status).to(eq(200))
      end
    end

    context "/movies/search/:genre" do
      it "returns a 200 OK" do
        get '/movies/search?genre=action'

        expect(last_response.status).to(eq(200))
      end
    end
  end
end
