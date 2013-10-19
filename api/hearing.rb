module BookingElements
  class Hearing < Grape::API
    format :json

    post '/hearing' do
      { :the_court => "a court session!" }
    end
  end
end
