
# == Schema Information
#
# Table name: prayer_configs
# t.integer  :id
# t.string   :PrayerConfig   , limit: 20, null: false
# t.string   :prayer   , limit: 20, null: false
# t.string   :label    , limit: 20, null: false
# t.integer  :limit    ,            null: false
# t.integer  :status   ,            null: false
#
# Indexes
#
# add_index(:prayer_configs, [:gender, :prayer], unique: true)
# add_index(:prayer_configs, [:gender, :prayer, :status])
#

class PrayerConfig < ApplicationRecord

  has_many :slot_availabilities, dependent: :destroy

  scope :active, -> { where("status = #{ApplicationRecord.statuses[:active]}" ) }
  # PrayerConfig.create(gender: User.genders[:female], label: 'Fajr', prayer: 'fajr', limit: 60, status: ApplicationRecord.statuses[:active])

  # PrayerConfig.create(gender: User.genders[:female],
  #                     label: 'Eid 1',
  #                     prayer: 'eid_1',
  #                     limit: 250,
  #                     start_date: Date.current + 1,
  #                     end_date: Date.current + 1,
  #                     status: ApplicationRecord.statuses[:active]
  # )

  def self.prayer_slots
    PrayerConfig.active
  end

  def decrement_availability(date:)
    slot_track = self.slot_availabilities.find_by(date: date)
    if slot_track.available_slots <= 0
      raise self.label + ' is already full, please select a different date or prayer.'
    end

    slot_track.available_slots = slot_track.available_slots - 1
    slot_track.save
  end

  def increment_availability(date:)
    slot_track = self.slot_availabilities.find_by(date: date)
    slot_track.available_slots = slot_track.available_slots + 1
    slot_track.save
  end
end
