require 'encryption_service'

class Api::V1::BookingsController < ApplicationController
  include Api::V1::BookingsHelper

  skip_before_action :verify_authenticity_token

  def index
    setup_slot_availability
    slots = get_available_slots

    render :json => {status: :success, slots: slots || []}
  end

  def create
    @user = User.find_or_create_by(phone_id: strong_params[:deviceId])
    return unless validate_create

    list_requested_slots = save_requested_prayers
    unless list_requested_slots.first.email.blank?
      UserMaileMailer.with(
        requested_slots: list_requested_slots, to: list_requested_slots.first.email).prayer_confirmation_email.deliver_now
    end
    render :json => { :status => "success" }
  rescue => e
    render :json => { :status => "error", message: e }
  end

  def show
    render :json => {
      :id => params[:id],
    }
  end

  def get_available_slots
    final_data = {}
    booking_days_range.each do |date|
      data = {}
      User.genders.each do |gender|
        slots = PrayerConfig
                  .joins(:slot_availabilities)
                  .select("slot_availabilities.*, prayer_configs.prayer, prayer_configs.label, prayer_configs.gender, prayer_configs.group")
                  .where("slot_availabilities.date": date)
                  .where("prayer_configs.gender": gender)
                  .order('prayer_configs.group')
                  .order('prayer_configs.id')
                  .group_by{|e| [e.group]}
                  .values

        next if slots.empty?
        data[gender[0]] = slots
      end
      next if data.empty?
      final_data[date] = data
    end
    final_data
  end

  def setup_slot_availability
    date_list = booking_days_range
    date_list.each_with_index do |date, index|
      next if index+1 == date_list.length && Time.now.hour < 12
      PrayerConfig.prayer_slots.each do |slot|
        unless SlotAvailability.where(prayer_config_id: slot.id, date: date).exists?

          availability = slot.slot_availabilities.new(available_slots: slot.limit, date: date)
          if slot.start_date.nil? || slot_config_in_range?(slot, date)
            next if (slot.prayer.include? 'jummah') && date.wday != 5 # 5 = Friday
            begin
              availability.save
            rescue ActiveRecord::RecordNotUnique => e
              logger.info "**INFO** Rescued duplicate insert for " + slot.inspect + " " +  e.inspect
            end
          end
        end
      end
    end
  end

  def save_requested_prayers
    list_requested_slots = []
    strong_params[:prayers].each do |prayer|
      ActiveRecord::Base.transaction do
        requested_slot = @user.requested_slots.create(
          gender:         User.genders[strong_params[:gender]],
          prayer:         prayer,
          date:           strong_params[:date],
          full_name:      strong_params[:full_name],
          phone_number:   strong_params[:phone_number],
          email:          strong_params[:email],
          address_line_1: strong_params[:address_line_1],
          address_line_2: strong_params[:address_line_2],
          city:           strong_params[:city],
          postcode:       strong_params[:postcode],
          status:         ApplicationRecord.statuses[:active]
        )
        list_requested_slots << requested_slot
        prayer_config = PrayerConfig.find_by(
          prayer: prayer,
          gender: User.genders[strong_params[:gender]]
        )
        prayer_config.decrement_availability(date: strong_params[:date])
      end
    end
    list_requested_slots
  end

  def validate_create
    error = {:status => "error", message: ''}
    if strong_params[:prayers] == []
      error[:message] = 'Select one more more prayer'
      render :json => error
      return false
    end

    strong_params[:prayers].each do |prayer|
      booked_slots = @user.requested_slots.where(
        prayer: prayer,
        date:   strong_params[:date],
        status: ApplicationRecord.statuses[:active]
      )
      next if booked_slots.nil?
      puts booked_slots, "***"
      if booked_slots.length >= 2
        prayer_label = PrayerConfig.find_by(prayer: prayer).label
        error[:message] = "You have reached your limit for #{prayer_label}, Please use different date"
        render :json => error
        return false
      end
    end
    true
  end

  def strong_params
    params.require(:booking).permit(
      :gender,
      :date,
      :full_name,
      :phone_number,
      :email,
      :address_line_1,
      :address_line_2,
      :city,
      :postcode,
      :deviceId,
      :prayers => []
    );
  end
end
