# ENV["SINATRA_ENV"] = "test"
# require_relative '../config/environment'
# require 'rack/test'
# require 'capybara/rspec'
# require 'capybara/dsl'

require_relative '../lib/tic_tac_toe'

RSpec.configure do |config|
  # config.run_all_when_everything_filtered = true
  # config.filter_run :focus
  # config.include Rack::Test::Methods
  # config.include Capybara::DSL
  # config.order = 'default'  
end