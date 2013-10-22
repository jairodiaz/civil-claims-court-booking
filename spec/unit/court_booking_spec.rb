require 'spec_helper'

describe 'Booking a Court' do
  before(:all) do
    Court.create(name: 'Test Court') #id should be 1
  end

  describe 'Choosing an appointment' do

    it "should return 201" do
      post '/courts', court_id: 1, session_name: 'repossesion claims', starting_date: '2013-10-15', starting_time: '10:00:00'
      expect(last_response.status).to eq 201
    end

    it "should return a court booking" do
      post '/courts', court_id: 1, session_name: 'repossesion claims', starting_date: '2013-10-15', starting_time: '10:00:00'
      response = {
        "name" => "repossesion claims",
        "starting_date" => "2013-10-15",
        "starting_hour" => "10:00:00",
        "ending_hour" =>  "10:30:00",
        "frequency" => "weekly",
        "court" => {
          "id" => 1,
          "name" => "Test Court"
        }
      }
      expect(last_response.body).to eq response.to_json
    end

    it "should find the court" do
      pending
      Court.should_receive(:find)
      post '/courts', court_id: 1, session_name: 'repossesion claims', starting_date: '2013-10-15', starting_time: '10:00:00'
    end

    context 'When the court does not exist' do
      before(:each) do
        post '/courts', court_id: 999, session_name: 'repossesion claims', starting_date: '2013-10-15', starting_time: '10:00:00'
      end
      it "should return 402" do
        expect(last_response.status).to eq 402
      end
      it "should return empty if the court is not found" do
        expect(last_response.body).to eq({}.to_json)
      end
    end

    xit "should store a court booking" do

    end

  end

  describe 'Requesting a time for a claim' do
    #scenario 'There is availability in the current slot' do
    #post '/book_hearing', hearing_name: 'Mr. Monsanto', earliest_dat: '2013-10-15 10:00:00'
    #expect(last_response.status).to eq 200
  end
end
