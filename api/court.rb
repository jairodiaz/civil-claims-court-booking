module BookingElements
  class CourtBooking < Grape::API
    format :json

    post '/courts' do
      status 201
      court = ::Court.find(params[:court_id])
      {
        "name" => "repossesion claims",
        "starting_date" =>  "2013-10-15",
        "starting_hour" => "10:00:00",
        "ending_hour" =>  "10:30:00",
        "frequency" => "weekly",
        "court" => {
          "id" => court.id,
          "name" => court.name
        }
      }
    end
  end
end
