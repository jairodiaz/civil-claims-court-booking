module BookingElements
  class CourtBooking < Grape::API
    format :json

    post '/courts' do
      court = ::Court.where(id: params[:court_id]).first
      if court.nil?
        status 402
        return {}
      end

      ::CourtBooking.create({
        name: params[:name],
        starting_date: params[:starting_date],
        starting_hour: params[:starting_hour],
        ending_hour: (params[:ending_hour] || params[:starting_hour]),
        frequency: params[:frequency] || "weekly",
        court_id: court.id
      })

      status 201
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
