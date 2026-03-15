class RemoveExpirationDateFromProduits < ActiveRecord::Migration[7.1]
  def change
    remove_column :produits, :expiration_date, :date
    rename_column :liste_de_prix_items, :prod_expiration_date, :expiration_date
  end
end
