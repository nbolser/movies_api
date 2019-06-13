# frozen_string_literal: true

require 'spec_helper'

describe API::Movies, type: :request do
  include Rack::Test::Methods

  def app
    API::Movies
  end

  context 'API endpoints' do
    context 'Invalid endpoint' do
      it 'should not load pages that do not exist' do
        get '/foo'

        expect(last_response.status).to(eq(404))
      end
    end

    context '/movies' do
      it 'returns a 200 OK' do
        get '/movies'

        expect(last_response.status).to(eq(200))
      end

      it 'returns a paginated data' do
        get '/movies'
        response = JSON.parse(last_response.body)

        expect(response.count).to(eq(50))
      end

      it 'returns a paginated data' do
        get '/movies?page=4'
        response = JSON.parse(last_response.body)

        expect(response.count).to(eq(50))
      end

      it 'returns a JSON data' do
        get '/movies'
        response = JSON.parse(last_response.body)

        expect(response.first.keys).to(match_array(["imdbId", "title", "genres", "releaseDate", "budget"]))
      end
    end

    context '/movies/:id/details' do
      it 'returns a 400 when id is not passed' do
        get '/movies/x/details'

        expect(last_response.status).to(eq(400))
      end

      it 'returns a 404 Not Found when id is not passed' do
        get '/movies/1/details'

        expect(last_response.status).to(eq(404))
      end

      it 'returns a 200 OK' do
        get '/movies/1421/details'

        expect(last_response.status).to(eq(200))
      end

      it 'returns a 200 OK' do
        get '/movies/1421/details'

        expect(last_response.status).to(eq(200))
      end
    end

    context '/movies/search/:year' do
      it 'returns a 200 OK' do
        get '/movies/search?releaseDate=1999'

        expect(last_response.status).to(eq(200))
      end

      it 'returns a paginated data by page' do
        get '/movies/search?releaseDate=1999&page=4'
        response = JSON.parse(last_response.body)

        expect(response.count).to(eq(50))
      end

      it 'returns a paginated data by page' do
        get '/movies/search?releaseDate=1999&page=4&order=DESC'
        response = JSON.parse(last_response.body)

        expect(response.first['releaseDate']).to(eq('1999-10-19'))
      end
    end

    context '/movies/search/:genre' do
      it 'returns a 200 OK' do
        get '/movies/search?genres=action'

        expect(last_response.status).to(eq(200))
      end

      it 'returns a paginated data by page' do
        get '/movies/search?genres=Action&page=4'
        response = JSON.parse(last_response.body)

        expect(response.count).to(eq(50))
      end
    end
  end
end
