require_relative '../spec_helper.rb'

describe 'Booking a hearing' do

  describe 'Requesting a time for a claim' do
    #scenario 'There is availability in the current slot' do
    it 'should return 201' do
      post '/hearing', name: 'Mr. Monsanto', earliest_date: '2013-10-15'
      expect(last_response.status).to eq 201
    end
  end
end
