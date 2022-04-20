class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.text :name
      t.text :currency
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
