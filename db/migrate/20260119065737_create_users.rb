class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :second_name
      t.string :phone
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end
