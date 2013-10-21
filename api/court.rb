module BookingElements
  class CourtBooking < Grape::API
    format :json

    post '/courts' do
      status 201
      {
        "booking_name" => "repossesion claims",
        "starting_date" =>  "2013-10-15",
        "starting_hour" => "10:00:00",
        "ending_hour" =>  "10:30:00",
        "court_name"  => "Court 1",
        "court_id" => 1,
        "frequency" => "weekly"
      }
    end
  end
end
