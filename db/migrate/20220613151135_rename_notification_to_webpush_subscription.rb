class RenameNotificationToWebpushSubscription < ActiveRecord::Migration[7.0]
  def change
    rename_table :notifications, :webpush_subscriptions
  end
end
