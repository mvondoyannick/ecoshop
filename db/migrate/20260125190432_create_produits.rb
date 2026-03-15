class CreateProduits < ActiveRecord::Migration[7.1]
  def change
    create_table :produits do |t|
      t.string :name
      t.string :category
      t.string :udm
      t.string :udm_value

      t.timestamps
    end
  end
end
