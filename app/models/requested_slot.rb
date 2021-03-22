
# == Schema Information
#
# Table name: slot_availabilities
# t.integer    :id
# t.belongs_to :prayer_config
# t.datetime   :date  ,           null: false
# t.integer    :available_slots , null: false
#
# Indexes
# add_index(:slot_availabilities, [:date])
#

class RequestedSlot < ApplicationRecord
  belongs_to :user

  # User.last.requested_slots.create(
  #   gender: User.genders[:male],
  #   prayer: "isha",
  #   email:  "up694452@myport.ac.uk",
  #   date:   Time.now,
  #   status: ApplicationRecord.statuses[:active]
  # )

end
