# frozen_string_literal: true

require 'rspec/core/rake_task'

require_relative 'config/application.rb'

task(default: :spec)

desc('Start IRB with application environment loaded')
task :console do
  exec "pry -r./config/application"
end

desc("Run specs")
task :spec do
  RSpec::Core::RakeTask.new(:spec)
end

desc("Run the specs")
task :start do
  exec "rackup"
end
