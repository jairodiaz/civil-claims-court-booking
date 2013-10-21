class CreateCourtBookings < ActiveRecord::Migration
  def self.up
    create_table :court_bookings do |t|
      t.string :name
      t.date :starting_date
      t.time :starting_hour
      t.time :ending_hour
      t.string :frequency
      t.integer :court_id
    end
    add_index :court_bookings, :name
  end

  def self.down
    drop_table :court_bookings
  end
end
