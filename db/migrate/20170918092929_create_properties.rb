class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :subdomain
      t.string :name
      t.string :email
      t.string :time_zone
      t.string :currency

      t.timestamps
    end
  end
end
