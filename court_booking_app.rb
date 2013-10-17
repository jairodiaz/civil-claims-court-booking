$: << File.join(File.dirname(__FILE__), ".", "lib") <<
      File.join(File.dirname(__FILE__), ".", "api")

require 'sinatra'
#require 'venue_finder'
require 'awesome_print'
require 'pry'
require 'grape'
require 'json'

enable :sessions

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def checker(boolean)
    'checked' if boolean
  end

  def address(address)
    begin
      location = "#{address['address']}&nbsp;#{address['postalCode']}"
    rescue
      "&nbsp;"
    end
  end
end

require 'court'
require 'hearing'

class API < Grape::API
  mount ::Court
  mount ::Hearing
end
