module BookingElements
  def self.format_time(time)
    time.strftime("%H:%M")
  end
  class CourtAPI < Grape::API
    format :json

    params do
      requires :name, type: String, desc: 'Name of the booking.'
      requires :court_id, type: Integer, desc: 'Court id.'
      requires :starting_date, type: Date, desc: 'Starting date.'
      requires :starting_hour, type: Time, desc: 'Starting hour.'
    end
    post '/courts' do
      logger.info("Params are: #{params}")
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
        present booking, with: ::CourtBooking::Entity, court: court
      rescue => e
        error!("Booking not created: #{e.message}", 422)
      end
    end
  end
end
