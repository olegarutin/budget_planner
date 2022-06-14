class CreatingNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :endpoint
      t.string :auth_key
      t.string :p256dh_key

      t.timestamps
    end
  end
end
