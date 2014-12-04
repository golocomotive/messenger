class CreateMessengerMessages < ActiveRecord::Migration
  def change
    create_table :messenger_messages do |t|

      t.timestamps
    end
  end
end
