class AddProdExpirationDateToListeDePrixItems < ActiveRecord::Migration[7.1]
  def change
    add_column :liste_de_prix_items, :prod_expiration_date, :date
  end
end
