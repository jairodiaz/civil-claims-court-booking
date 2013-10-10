require 'spec_helper'

feature 'Managing Court time slot bookings' do

  scenario 'Setting a time slot' do
    post '/book', { session_name: 'reposession claims', starting_date: '2013-10-15 10:00:00' }
    pp last_response
    expect(last_response.status).to eq 200
  end

end
