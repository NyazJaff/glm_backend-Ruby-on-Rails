
# == Schema Information
#
# Table name: create_table
# t.integer  :id
# t.string   :phone_id, limit: 100, null: false
# t.string   :status  , limit: 10,  null: false, default: ApplicationRecord.statuses[:active]
#
# Indexes
# add_index(:users, [:phone_id], unique: true)
#

class SlotAvailability < ApplicationRecord
  belongs_to :prayer_config


  def self.availability_slot_created?
    availability

  end
end
