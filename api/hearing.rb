module BookingElements
  class HearingAPI < Grape::API
    format :json

    post '/hearings' do
      { :the_court => "a court session!" }
    end
  end
end
