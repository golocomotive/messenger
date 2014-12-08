class CreateMessengerMemberships < ActiveRecord::Migration
  def change
    create_table :messenger_memberships do |t|
      t.belongs_to :group,  required: true
      t.belongs_to :member, required: true, polymorphic: true
      t.timestamps
    end

    add_index :messenger_memberships, [:group_id]
    add_index :messenger_memberships, [:member_type]
    add_index :messenger_memberships, [:member_id, :member_type], name: :imm
  end
end
