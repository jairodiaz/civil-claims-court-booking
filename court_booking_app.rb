$: << File.join(File.dirname(__FILE__), ".", "lib")

require 'sinatra'
#require 'venue_finder'
require 'awesome_print'
require 'pry'
require 'grape'

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

class Hearing < Grape::API
  format :json
  post '/hearing' do
    puts 'we are hearing'
    { :ping => "pong" }
  end
end
