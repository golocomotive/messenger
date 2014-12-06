class CreateMessengerGroups < ActiveRecord::Migration
  def change
    create_table :messenger_groups do |t|
      t.string     :name,  required: true
      t.belongs_to :owner, required: true, polymorphic: true, index: true
      t.timestamps
    end

    add_index :messenger_groups, [:name]
    add_index :messenger_groups, [:name, :owner_id, :owner_type], unique: true
  end
end
