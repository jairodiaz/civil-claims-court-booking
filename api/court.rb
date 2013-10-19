module BookingElements
  class Court < Grape::API
    format :json

    post '/book_court' do
      status 200
      {
        "session_name" => "repossesion claims",
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
