# frozen_string_literal: true

require_relative '../../config/application.rb'

module API
  class Movies < Grape::API
    resource :movies do
      format :json

      params do
        optional :page, type: String
      end

      get do
        Movie
          .all
          .paginate(page: (params[:page] || 1).to_i)
      end

      params do
        requires :id, coerce: Integer, desc: 'Search movie details'
      end
      get ':id/details' do
        data = Movie.find_details(params[:id])
        if !data.empty?
          data
        else
          error!(:not_found, 404)
        end
      end

      namespace :search do
        params do
          optional :page, type: String
          optional :year, type: String, regexp: /^\d{4}/
          optional :genre, type: String
          optional :order, type: String, default: 'ASC'
        end

        get do
          Movie
            .search(params)
            .paginate(page: (params[:page] || 1).to_i)
        end
      end
    end
  end
end
