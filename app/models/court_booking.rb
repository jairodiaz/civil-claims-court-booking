class CourtBooking < ActiveRecord::Base
  belongs_to :court

  class Entity < Grape::Entity
    format_with(:hour_format) { |time| time.strftime("%H:%M") }
    expose :name
    expose :starting_date
    with_options(format_with: :hour_format) do
      expose :starting_hour
      expose :ending_hour
    end
    expose :frequency
    expose :court do |booking, options|
      options[:court].serializable_hash
    end
  end
end
