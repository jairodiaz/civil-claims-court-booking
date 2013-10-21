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
