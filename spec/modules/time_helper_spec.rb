require 'rails_helper'

RSpec.describe TimeHelper do
  describe 'length_of_trip' do
    it 'can find the nearest_hour of a time' do
      trip_time = "14:29:59"

      expect(TimeHelper.length_of_trip(trip_time)).to eq(14)

      trip_time2 = "14:30:10"

      expect(TimeHelper.length_of_trip(trip_time2)).to eq(15)
    end
  end
end
