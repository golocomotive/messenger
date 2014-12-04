class CreateMessengerMessages < ActiveRecord::Migration
  def change
    create_table :messenger_messages do |t|
      t.text :body
      t.datetime :read_at
      t.belongs_to :sender, index: true

      t.timestamps
    end
  end
end
