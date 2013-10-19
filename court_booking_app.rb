$: << File.join(File.dirname(__FILE__), ".", "lib") <<
      File.join(File.dirname(__FILE__), ".", "api")

require 'sinatra'
require 'awesome_print'
require 'pry'
require 'grape'

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

require 'court'
require 'hearing'

class API < Grape::API
  mount ::BookingElements::Court
  mount ::BookingElements::Hearing
end
