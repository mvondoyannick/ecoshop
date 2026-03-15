class AddStatusToVilles < ActiveRecord::Migration[7.1]
  def change
    add_column :villes, :status, :string, default: "Planifiée"
  end
end
