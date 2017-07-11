class AddConfirmationCodeToStays < ActiveRecord::Migration[5.1]
  def change
    add_column :stays, :confirmation_code, :string
  end
end
