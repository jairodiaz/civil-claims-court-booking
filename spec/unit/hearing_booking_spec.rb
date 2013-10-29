require_relative '../spec_helper.rb'

describe 'Booking a Hearing' do

  describe 'Requesting an appointment' do
    context 'when there is availability in the current slot' do
      it 'should return 201' do
        post '/hearings', name: 'Mr. Monsanto', earliest_date: '2013-10-15'
        expect(last_response.status).to eq 201
      end
    end
  end
end
