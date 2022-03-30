class AddMessagesCountToInboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :inboxes, :messages_count, :integer , default: 0, null: false
  end
end
