class ChangeAmountTypeForTransactions < ActiveRecord::Migration[7.0]
  def up
    change_table :transactions do |t|
      t.change :amount, :bigint
    end
  end

  def down
    change_table :transactions do |t|
      t.change :amount, :integer
    end
  end
end
