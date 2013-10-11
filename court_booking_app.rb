$: << File.join(File.dirname(__FILE__), ".", "lib")

require 'sinatra'
#require 'venue_finder'
require 'awesome_print'
require 'pry'

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

post '/book_court' do
  status 200
  "text"
end
