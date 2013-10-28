$: << File.join(File.dirname(__FILE__), ".", "lib") <<
      File.join(File.dirname(__FILE__), ".", "api")

require 'sinatra'
require 'sinatra/activerecord'
require 'awesome_print'
require 'pry'
require 'grape'
require 'grape-entity'
require 'grape-swagger'
require 'rack/cors'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

# Database configuration for different environments
database_urls = {
  :development => 'sqlite://bookings-development.db',
  :production     => 'sqlite://bookings-production.db',
  :test       => 'sqlite://bookings-test.db'
}
puts "Running with database for #{settings.environment} environment"
set :database, database_urls[settings.environment]

# Set up logger
ActiveRecord::Base.logger = Logger.new File.expand_path("../log/#{settings.environment}.log", __FILE__)

# Enable CORS for API Documentation
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, :methods => [:get, :post, :put, :delete, :options]
  end
end

require 'court'
require 'hearing'

class Court < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :court_bookings
end

class CourtBooking < ActiveRecord::Base
  belongs_to :court
  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    format_with(:hour_format) { |time| time.strftime("%H:%M") }
    expose :name
    expose :starting_date
    with_options(format_with: :hour_format) do
      expose :starting_hour
      expose :ending_hour
    end
    expose :frequency
    expose :court do |booking, options|
      options[:court].serializable_hash
    end
  end
end

class API < Grape::API
  content_type :txt, "text/plain"
  #content_type :json, "application/json"

 helpers do
    def logger
      ActiveRecord::Base.logger
    end
  end

  mount ::BookingElements::CourtAPI
  mount ::BookingElements::HearingAPI

  # Documentation available at: http://localhost:9292/swagger_doc.json
  add_swagger_documentation api_version: 'v1'
end
