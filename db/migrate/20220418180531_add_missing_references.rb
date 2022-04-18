class AddMissingReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :user, foreign_key: true
    add_reference :wallets, :user, foreign_key: true
    add_reference :transactions, :category, foreign_key: true
  end
end
