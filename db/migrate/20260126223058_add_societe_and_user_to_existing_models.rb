class AddSocieteAndUserToExistingModels < ActiveRecord::Migration[7.1]
  def change
    [:supermarches, :produits, :liste_de_prixes].each do |table|
      add_reference table, :societe, null: true, foreign_key: true
      add_reference table, :user, null: true, foreign_key: true
    end
  end
end
