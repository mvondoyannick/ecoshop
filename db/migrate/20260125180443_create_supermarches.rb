class CreateSupermarches < ActiveRecord::Migration[7.1]
  def change
    create_table :supermarches do |t|
      t.string :name
      t.string :logo
      t.string :email
      t.string :phone
      t.references :ville, null: false, foreign_key: true
      t.string :code
      t.string :quartier
      t.string :lieu_dit
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
