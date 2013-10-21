module BookingElements
  class Hearing < Grape::API
    format :json

    post '/hearings' do
      { :the_court => "a court session!" }
    end
  end
end
