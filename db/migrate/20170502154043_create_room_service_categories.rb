class CreateRoomServiceCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :room_service_categories do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
