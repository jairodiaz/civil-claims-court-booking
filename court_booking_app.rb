$: << File.join(File.dirname(__FILE__), ".", "lib") <<
      File.join(File.dirname(__FILE__), ".", "api")

require 'sinatra'
require 'sinatra/activerecord'
require 'awesome_print'
require 'pry'
require 'grape'

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

require 'court'
require 'hearing'

class Court < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :court_bookings
end

class CourtBooking < ActiveRecord::Base
  belongs_to :court
end

class API < Grape::API
  mount ::BookingElements::CourtBooking
  mount ::BookingElements::HearingBooking
end
