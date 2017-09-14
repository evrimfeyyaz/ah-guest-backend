module Tod
  class TimeOfDay
    def utc_from_zone(zone_name)
      date_time = nil

      Time.use_zone(zone_name) do
        date_time = on Date.today
      end

      Tod::TimeOfDay(date_time.utc)
    end
  end
end