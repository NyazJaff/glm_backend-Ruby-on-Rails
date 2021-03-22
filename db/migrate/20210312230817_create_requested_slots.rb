class CreateRequestedSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :requested_slots do |t|
      t.belongs_to :user
      t.string     :gender , limit: 10, null: false
      t.string     :prayer , limit: 10, null: false
      t.string     :email  , limit: 50
      t.date       :date   ,            null: false
      t.integer    :status , limit: 2 , null: false, default: ApplicationRecord.statuses[:active]
      t.timestamps
    end

    add_index(:requested_slots, [:prayer, :date, :status] ,
    name: 'index_requested_slots_phone_to_status')
  end
end
