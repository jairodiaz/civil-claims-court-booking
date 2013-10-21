require 'spec_helper'

describe 'Booking a Court' do

  describe 'Choosing an appointment' do
    it "should return 201" do
      post '/courts', court_id: 1, session_name: 'repossesion claims', starting_date: '2013-10-15', starting_time: '10:00:00'
      expect(last_response.status).to eq 201
    end

    it "should return a court booking" do
      Court.create(name: 'Test Court') #id should be 1

      post '/courts', court_id: 1, session_name: 'repossesion claims', starting_date: '2013-10-15 10:00:00'
      response = {
        "name" => "repossesion claims",
        "starting_date" =>  "2013-10-15",
        "starting_hour" => "10:00:00",
        "ending_hour" =>  "10:30:00",
        "frequency" => "weekly",
        "court" => {
          "id" => 1,
          "name" => "Court 1"
        }
      }
      expect(last_response.body).to eq response.to_json
    end
  end

  describe 'Requesting a time for a claim' do
    #scenario 'There is availability in the current slot' do
    #post '/book_hearing', hearing_name: 'Mr. Monsanto', earliest_dat: '2013-10-15 10:00:00'
    #expect(last_response.status).to eq 200
  end
end
