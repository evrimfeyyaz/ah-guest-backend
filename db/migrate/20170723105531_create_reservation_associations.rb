class CreateReservationAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_associations do |t|
      t.references :reservation, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
