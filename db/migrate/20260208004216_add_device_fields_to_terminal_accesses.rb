class AddDeviceFieldsToTerminalAccesses < ActiveRecord::Migration[7.1]
  def change
    add_column :terminal_accesses, :device_brand, :string
    add_column :terminal_accesses, :device_model, :string
    add_column :terminal_accesses, :device_type, :string
  end
end
