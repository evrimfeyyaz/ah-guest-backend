class CreateStays < ActiveRecord::Migration[5.1]
  def change
    create_table :stays do |t|
      t.references :user, foreign_key: true
      t.date :check_in_date
      t.date :check_out_date
      t.integer :room_number

      t.timestamps
    end
  end
end
