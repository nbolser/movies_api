# frozen_string_literal: true

require_relative '../../config/application.rb'

module API
  class Movies < Grape::API
    resource :movies do
      format :json

      params do
        optional :page, type: String, default: 1
      end

      get do
        { "hello": "index" }
      end

      params do
        requires :id, coerce: Integer, desc: 'Search movie details'
      end
      get ':id/details' do
        { "hello": "details" }
      end

      namespace :search do
        params do
          optional :page, type: String, default: 1
          optional :year, type: String, desc: 'Year in YYYY-MM-DD format', regexp: /^\d{4}/
          optional :genre, type: String, desc: 'Genre; Crime, Action'
        end

        get do
          { "hello": "search" }
        end
      end
    end
  end
end
