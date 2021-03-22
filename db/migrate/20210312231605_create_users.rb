class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string   :phone_id, limit: 100, null: false
      t.integer  :status  , limit: 2  , null: false, default: ApplicationRecord.statuses[:active]
      t.timestamps
    end

    add_index(:users, [:phone_id], unique: true)
  end
end
