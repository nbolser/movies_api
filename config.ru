# frozen_string_literal: true

$LOAD_PATH.unshift("app/api")

require 'movies'

run(API::Movies)
