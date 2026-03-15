class CreateListeDePrixes < ActiveRecord::Migration[7.1]
  def change
    create_table :liste_de_prixes do |t|
      t.references :supermarche, null: false, foreign_key: true

      t.timestamps
    end
  end
end
