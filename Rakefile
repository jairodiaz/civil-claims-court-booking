require ::File.expand_path('../court_booking_app.rb',  __FILE__)
require 'sinatra/activerecord/rake'

desc "Load test Court"
task :test_data do
  puts "Inserting test data..."
  Court.find_or_create_by_name('Cambridge Crown Court')
  courts = Court.all
  courts.each { |court| puts "Inserted: #{court.name} [id = #{court.id}]" }
  puts 'Completed'
end
