class CreateMessengerReceipts < ActiveRecord::Migration
  def change
    create_table :messenger_receipts do |t|
      t.belongs_to :message,    required: true
      t.belongs_to :recipient,  required: true, polymorphic: true
      t.timestamps
    end

    add_index :messenger_receipts, [:message_id]
    add_index :messenger_receipts, [:recipient_id, :recipient_type]
    add_index :messenger_receipts, [:message_id, :recipient_id, :recipient_type], name: :mrr
  end
end
