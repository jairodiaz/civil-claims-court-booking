module BookingElements
  def self.format_time(time)
    time.strftime("%H:%M")
  end
  class CourtAPI < Grape::API
    format :json

    params do
      requires :court_id, type: Integer, desc: 'Court id.'
      requires :starting_date, type: Date, desc: 'Starting date.'
      requires :starting_hour, type: Time, desc: 'Starting hour.'
    end
    post '/courts' do
      court = ::Court.where(id: params[:court_id]).first
      error!('Court not found', 422) if court.nil? # It may be 402

      begin
        starting_hour = params[:starting_hour]
        booking = ::CourtBooking.create!({
          name: params[:name],
          starting_date: params[:starting_date],
          starting_hour: starting_hour,
          ending_hour: starting_hour + 30.minutes,
          frequency: params[:frequency] || "weekly",
          court_id: court.id
        })

        status 201
        {
          "name" => booking.name,
          "starting_date" => booking.starting_date,
          "starting_hour" => BookingElements.format_time(booking.starting_hour),
          "ending_hour" => BookingElements.format_time(booking.ending_hour),
          "frequency" => booking.frequency,
          "court" => {
            "id" => court.id,
            "name" => court.name
          }
        }
      rescue => e
        error!("Booking not created: #{e.message}", 422)
      end
    end
  end
end
