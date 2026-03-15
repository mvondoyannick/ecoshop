class AddStatusToSupermarches < ActiveRecord::Migration[7.1]
  def change
    add_column :supermarches, :status, :string
  end
end
