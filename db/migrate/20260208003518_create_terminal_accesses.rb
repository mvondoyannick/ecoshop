class CreateTerminalAccesses < ActiveRecord::Migration[7.1]
  def change
    create_table :terminal_accesses do |t|
      t.string :ip_address
      t.string :country
      t.string :url
      t.text :user_agent
      t.boolean :blocked, default: false

      t.timestamps
    end
  end
end
