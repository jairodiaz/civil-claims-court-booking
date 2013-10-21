require 'spec_helper'

describe 'Booking a Court' do

  describe 'Choosing an appointment' do
    it "should return 201" do
      post '/courts', court_id: 1, session_name: 'repossesion claims', starting_date: '2013-10-15', starting_time: '10:00:00'
      expect(last_response.status).to eq 201
    end

    it "should return a court booking" do
      post '/courts', court_id: 1, session_name: 'repossesion claims', starting_date: '2013-10-15 10:00:00'
      response = {
        "session_name" => "repossesion claims",
        "starting_date" =>  "2013-10-15",
        "starting_hour" => "10:00:00",
        "ending_hour" =>  "10:30:00",
        "court_name"  => "Court 1",
        "court_id" => 1,
        "frequency" => "weekly"
      }.to_json
      expect(last_response.body).to eq response
    end
  end

  describe 'Requesting a time for a claim' do
    #scenario 'There is availability in the current slot' do
    #post '/book_hearing', hearing_name: 'Mr. Monsanto', earliest_dat: '2013-10-15 10:00:00'
    #expect(last_response.status).to eq 200
  end
end
