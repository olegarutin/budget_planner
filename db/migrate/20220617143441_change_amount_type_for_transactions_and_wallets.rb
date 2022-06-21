class ChangeAmountTypeForTransactionsAndWallets < ActiveRecord::Migration[7.0]
  def up
    change_table :transactions do |t|
      t.change :amount, :bigint
    end

    change_table :wallets do |t|
      t.change :quantity, :bigint
    end
  end

  def down
    change_table :transactions do |t|
      t.change :amount, :integer
    end

    change_table :wallets do |t|
      t.change :quantity, :integer
    end
  end
end
