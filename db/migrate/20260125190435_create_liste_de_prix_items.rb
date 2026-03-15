class CreateListeDePrixItems < ActiveRecord::Migration[7.1]
  def change
    create_table :liste_de_prix_items do |t|
      t.references :liste_de_prix, null: false, foreign_key: true
      t.references :produit, null: false, foreign_key: true
      t.decimal :price
      t.date :start_date
      t.date :end_date
      t.decimal :discount
      t.string :discount_type
      t.integer :discount_quantity

      t.timestamps
    end
  end
end
