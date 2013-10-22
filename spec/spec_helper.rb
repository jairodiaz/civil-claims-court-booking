require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start

require 'capybara'
require 'capybara/rspec' #support for feature/scenario
require 'capybara-webkit'
require 'sinatra'

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")  <<
              File.join(File.dirname(__FILE__), "..", "spec") <<
              File.join(File.dirname(__FILE__), "..", ".")

settings.environment = :test
require 'court_booking_app'
#require_relative './support/some_helper'

#Capybara.app = Sinatra::Application.new
Capybara.save_and_open_page_path = File.join(File.dirname(__FILE__), "..", "tmp")
Capybara.javascript_driver = :selenium

# Important note about using: webkit (:webkit)
# 1. Webkit does not support HTTP Verb delete.
# 2. VCR is not compatible with capybara-wekbit, so test are slow and test
#    for listing favourites fails due to different recorded reply.

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

def app
  API
end
