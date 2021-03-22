class CreatePrayerConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :prayer_configs do |t|
      t.string   :gender     , limit: 20, null: false
      t.string   :prayer     , limit: 20, null: false
      t.string   :label      , limit: 20, null: false
      t.integer  :limit      ,            null: false
      t.integer  :status     , limit: 2 , null: false
      t.integer  :group      , limit: 2 , null: false, default: 3
      t.date     :start_date
      t.date     :end_date
      t.timestamps
    end

    add_index(:prayer_configs, [:gender, :prayer], unique: true)
    add_index(:prayer_configs, [:gender, :prayer, :status])
  end
end
