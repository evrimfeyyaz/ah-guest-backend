class CreateApiClients < ActiveRecord::Migration[5.1]
  def change
    create_table :api_clients do |t|
      t.string :name
      t.string :secret
      t.belongs_to :property, foreign_key: true

      t.timestamps
    end
  end
end
