# "14:25:59"
require 'time'

module TimeHelper
  def self.length_of_trip(trip_time)
    datetime = Time.parse(trip_time)
    array = datetime.to_a
    
    if array[1] < 30
      trip_time.to_i
    else
      trip_time.to_i + 1
    end
  end
end
