class ChangePrayerConfigLabelLength < ActiveRecord::Migration[6.1]
  def up
    change_column :prayer_configs, :label, :string, :limit => 100
  end

  def down
    change_column :prayer_configs, :label, :string, :limit => 20
  end
end
