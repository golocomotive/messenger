class CreateMessengerMessages < ActiveRecord::Migration
  def change
    create_table :messenger_messages do |t|
      t.text        :body
      t.string      :subject,     required: true
      t.belongs_to  :sender,      required: true, polymorphic: true, index: true
      t.datetime    :sent_at,     required: false
      t.timestamps
    end
  end
end
