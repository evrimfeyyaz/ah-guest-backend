require 'rails_helper'
require 'tod_extensions'

describe Tod::TimeOfDay do
  describe '#utc_from_zone' do
    it 'converts the time to UTC assuming the instance is in given zone' do
      tod = Tod::TimeOfDay.new(8)
      zone = 'Riyadh'
      tod_utc = Tod::TimeOfDay.new(5)

      converted_time = tod.utc_from_zone(zone)

      expect(converted_time).to eq(tod_utc)
    end
  end
end