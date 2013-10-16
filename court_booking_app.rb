$: << File.join(File.dirname(__FILE__), ".", "lib")

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

post '/book_court' do
  status 200
  content_type :json
  {
    "session_name" => "repossesion claims",
    "starting_date" =>  "2013-10-15",
    "starting_hour" => "10:00:00",
    "ending_hour" =>  "10:30:00",
    "court_name"  => "Court 1",
    "court_id" => 1,
    "frequency" => "weekly"
  }.to_json
end

class Hearing < Grape::API
  format :json
  post '/hearing' do
    puts 'we are hearing'
    { :ping => "pong" }
  end
end
