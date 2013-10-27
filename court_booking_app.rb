$: << File.join(File.dirname(__FILE__), ".", "lib") <<
      File.join(File.dirname(__FILE__), ".", "api")

require 'sinatra'
require 'sinatra/activerecord'
require 'awesome_print'
require 'pry'
require 'grape'
require 'grape-entity'

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

ActiveRecord::Base.logger = Logger.new File.expand_path("../log/#{settings.environment}.log", __FILE__)

require 'court'
require 'hearing'

class Court < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :court_bookings

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :name, :starting_date, :starting_hour, :ending_hour, :frequency
  end
end

class CourtBooking < ActiveRecord::Base
  belongs_to :court
end

class API < Grape::API
  mount ::BookingElements::CourtAPI
  mount ::BookingElements::HearingAPI
end
