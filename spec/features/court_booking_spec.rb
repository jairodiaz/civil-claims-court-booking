require 'spec_helper'

feature 'Managing Court time slot bookings' do

  scenario 'Setting a time slot' do
    post '/book_court', session_name: 'repossesion claims', starting_date: '2013-10-15 10:00:00'
    expect(last_response.status).to eq 200
  end

  scenario 'Requesting a time for a claim' do
    #scenario 'There is availability in the current slot' do
    post '/book_hearing', hearing_name: 'Mr. Monsanto', earliest_dat: '2013-10-15 10:00:00'
    expect(last_response.status).to eq 200
  end

end
