class AddNameLastNameAndSexToStays < ActiveRecord::Migration[5.1]
  def change
    add_column :stays, :name, :string
    add_column :stays, :last_name, :string
    # https://stackoverflow.com/a/4179714
    add_column :stays, :sex, :integer, limit: 1
  end
end
