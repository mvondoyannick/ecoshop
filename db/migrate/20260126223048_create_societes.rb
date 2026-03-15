class CreateSocietes < ActiveRecord::Migration[7.1]
  def change
    create_table :societes do |t|
      t.string :name
      t.string :phone
      t.references :ville, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
