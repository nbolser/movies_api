# frozen_string_literal: true

require 'sqlite3'
require 'grape'
require 'json'
require 'pry'
require 'rack/test'
require 'sequel'
require 'will_paginate/array'

require_relative '../app/helpers/database_helper.rb'
require_relative '../app/queries/movies_search_query.rb'
require_relative '../app/api/movies.rb'
require_relative '../app/model/movie.rb'

WillPaginate.per_page = 50
