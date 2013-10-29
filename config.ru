require 'rack/cors'

# Enable CORS for API Documentation
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, :methods => [:get, :post, :put, :delete, :options]
  end
end

require ::File.expand_path('../court_booking_app.rb',  __FILE__)
run API
