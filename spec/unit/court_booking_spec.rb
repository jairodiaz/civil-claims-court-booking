require 'spec_helper'

describe 'Booking a Court' do
  before(:all) do
    Court.find_or_create_by_name(name: 'Test Court')
  end

  describe 'Choosing an appointment' do

    context 'When the court does not exist' do
      before(:each) do
        post '/courts', court_id: 999, name: 'repossesion claims', starting_date: '2013-10-15', starting_hour: '10:00:00'
      end
      it "should return 402" do
        expect(last_response.status).to eq 402
      end
      it "should return empty if the court is not found" do
        expect(last_response.body).to eq({}.to_json)
      end
    end

    context 'When the court exists' do
      before(:each) do
        unless example.metadata[:skip_before]
          post '/courts', court_id: 1, name: 'repossesion claims', starting_date: '2013-10-15', starting_hour: '10:00:00'
        end
      end

      it "should return 201" do
        expect(last_response.status).to eq 201
      end

      it "should return a starting date in format 'YYYY-MM-DD'" do
        starting_date = JSON.parse(last_response.body)['starting_date']
        expect(starting_date).to eq('2013-10-15')
      end

      it "should return an starting time in format HH:MM" do
        starting_date = JSON.parse(last_response.body)['starting_hour']
        expect(starting_date).to eq('10:00')
      end

      it "should return an ending time in format HH:MM" do
        ending_hour = JSON.parse(last_response.body)['ending_hour']
        expect(ending_hour).to eq('10:00')
      end

      xit "should return a court booking" do
        response = {
          "name" => "repossesion claims",
          "starting_date" => "2013-10-15",
          "starting_hour" => "10:00",
          "ending_hour" =>  "10:30",
          "frequency" => "weekly",
          "court" => {
            "id" => 1,
            "name" => "Test Court"
          }
        }
        expect(last_response.body).to eq response.to_json
      end

      it "should find the court", skip_before: true do
        Court.should_receive(:where).with({:id => "1"}).and_return(mock("court").as_null_object)
        post '/courts', court_id: 1, name: 'repossesion claims', starting_date: '2013-10-15', starting_hour: '10:00:00'
      end

      xit "should store a court booking", skip_before: true do
        CourtBooking.should_receive(:create!).with({
          :name => "repossesion claims",
          :starting_date => "2013-10-15",
          :starting_hour => "10:00",
          :ending_hour => "10:30",
          :frequency => "weekly",
          :court_id => 1
        })
        post '/courts', court_id: 1, name: 'repossesion claims', starting_date: '2013-10-15', starting_hour: '10:00:00'
      end
    end
  end

  describe 'Requesting a time for a claim' do
    #scenario 'There is availability in the current slot' do
    #post '/book_hearing', hearing_name: 'Mr. Monsanto', earliest_dat: '2013-10-15 10:00:00'
    #expect(last_response.status).to eq 200
  end
end
