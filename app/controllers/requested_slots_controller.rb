class RequestedSlotsController < ApplicationController
  include Api::V1::BookingsHelper


  def user_slots
    active_slots = []
    user = User.find_by(phone_id: strong_params[:deviceId])
    if !user.nil?
      active_slots = User
        .joins("
        INNER JOIN requested_slots ON requested_slots.user_id = users.id
        INNER JOIN prayer_configs ON prayer_configs.prayer = requested_slots.prayer")
        .select("users.phone_id",
                "requested_slots.id",
                "requested_slots.date",
                "requested_slots.gender",
                "requested_slots.prayer",
                "prayer_configs.label",
                "requested_slots.status")
        .where("users.phone_id": strong_params[:deviceId])
        .where("requested_slots.date": booking_days_range)
        .where("requested_slots.status": ApplicationRecord.statuses[:active])
        .order('requested_slots.date')
        .distinct
    end
    render :json => { :status => 'success', data: active_slots }
  end

  def cancel_prayer
    requested_slot = RequestedSlot.find_by(id: strong_params[:id])
    unless requested_slot.nil?
      requested_slot.status = ApplicationRecord.statuses[:canceled]
      requested_slot.save
      increment_availability(requested_slot.prayer, requested_slot.gender, requested_slot.date)
    end
    render :json => { :status => 'success'}
  end

  def cancel_prayer_view
    @found = false
    @already_cancelled = true
    id = Base64.decode64(strong_params[:id])
    requested_slot = RequestedSlot.find_by(id: id)

    return unless requested_slot
    @found = true

    return if requested_slot.status == ApplicationRecord.statuses[:canceled]
    @already_cancelled = false

    requested_slot.status = ApplicationRecord.statuses[:canceled]
    requested_slot.save
    increment_availability(requested_slot.prayer, requested_slot.gender, requested_slot.date)
  end

  def increment_availability (prayer, gender, date )
    prayer_config = PrayerConfig.find_by(
      prayer: prayer,
      gender: gender
    )
    prayer_config.increment_availability(date: date)
  end


  def strong_params
    params.permit(:id, :deviceId)
  end
end
