class CreateSlotAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :slot_availabilities do |t|
      t.belongs_to :prayer_config
      t.date       :date  ,           null: false
      t.integer    :available_slots , null: false
      t.timestamps
    end

    add_index(:slot_availabilities, [:date, :prayer_config_id], unique: true)
  end
end
