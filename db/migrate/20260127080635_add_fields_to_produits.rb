class AddFieldsToProduits < ActiveRecord::Migration[7.1]
  def change
    # Add expiration_date as nullable first
    add_column :produits, :expiration_date, :date
    
    # Set a default expiration date for existing products (1 year from now)
    reversible do |dir|
      dir.up do
        execute "UPDATE produits SET expiration_date = CURRENT_DATE + INTERVAL '1 year' WHERE expiration_date IS NULL"
      end
    end
    
    # Now make it NOT NULL
    change_column_null :produits, :expiration_date, false
    
    add_column :produits, :sku, :string
    add_column :produits, :promotion, :boolean, default: false
    add_column :produits, :promotion_start_date, :date
    add_column :produits, :promotion_end_date, :date
    add_column :produits, :promotion_price, :decimal, precision: 10, scale: 2
    add_column :produits, :bulk_sale_quantity, :integer
    add_column :produits, :bulk_sale_discount_percentage, :decimal, precision: 5, scale: 2
    
    add_index :produits, :sku, unique: true
  end
end
