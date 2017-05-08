class AddDefaultValueToDefault < ActiveRecord::Migration[5.1]
  def up
    change_column :room_service_sections, :default, :boolean, default: false
  end

  def down
    change_column :room_service_sections, :default, :boolean, default: nil
  end
end
