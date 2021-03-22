
# == Schema Information
#
# Table name: users
# t.integer  :id
# t.string   :phone_id, limit: 100, null: false
# t.string   :status  , limit: 10,  null: false, default: ApplicationRecord.statuses[:active]
#
# Indexes
# add_index(:users, [:phone_id], unique: true)
#

class User < ApplicationRecord
  has_many :requested_slots, dependent: :destroy

  enum statuses: [:active, :canceled]
  enum genders:  [:male, :female]
  # user = User.create(phone_id: '123123', roles: 1)
end
