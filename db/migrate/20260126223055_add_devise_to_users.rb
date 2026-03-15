# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def self.up
    # Remove existing columns that devise or our new logic will redefine
    remove_column :users, :name if column_exists?(:users, :name)
    remove_column :users, :second_name if column_exists?(:users, :second_name)
    remove_column :users, :phone if column_exists?(:users, :phone)
    remove_column :users, :email if column_exists?(:users, :email)
    remove_column :users, :role if column_exists?(:users, :role)

    change_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.string :name
      t.string :second_name
      t.string :phone
      t.references :role, foreign_key: true
      t.references :societe, foreign_key: true
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
