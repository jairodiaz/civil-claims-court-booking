$: << File.join(File.dirname(__FILE__), ".", "app") <<
      File.join(File.dirname(__FILE__), ".", "api")

require 'sinatra'
require 'sinatra/activerecord'
require 'awesome_print'
require 'pry'
require 'grape'
require 'grape-entity'
require 'grape-swagger'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

# Database configuration for different environments
database_urls = {
  :development => 'sqlite://bookings-development.db',
  :production  => 'sqlite://bookings-production.db',
  :test       => 'sqlite://bookings-test.db'
}
puts "Running with database for #{settings.environment} environment"
set :database, database_urls[settings.environment]

# Set up logger
ActiveRecord::Base.logger = Logger.new File.expand_path("../log/#{settings.environment}.log", __FILE__)

require 'court'
require 'hearing'
require 'models/court'
require 'models/court_booking'

class API < Grape::API
  format :json
  default_format :json

  helpers do
    def logger
      # Use the same logger as ActiveRecord
      ActiveRecord::Base.logger
    end
  end

  mount ::BookingElements::CourtAPI
  mount ::BookingElements::HearingAPI

  # Documentation available at: http://127.0.0.1:9292/swagger_doc.json
  add_swagger_documentation
end
