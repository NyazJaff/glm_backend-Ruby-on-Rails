module Api::V1::BookingsHelper

  def booking_days_range
    days = []
    num_days = 4
    num_days.times do |index|
      days << Date.today + index
    end
    days
  end

  def slot_config_in_range?(slot, date)
    return true if slot.start_date <= date && slot.end_date >= date
    false
  end
end
