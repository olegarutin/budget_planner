class RemoveKindFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :kind, :integer
  end
end
