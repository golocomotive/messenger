# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141207230426) do

  create_table "messenger_groups", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messenger_groups", ["name", "owner_id", "owner_type"], name: "index_messenger_groups_on_name_and_owner_id_and_owner_type", unique: true
  add_index "messenger_groups", ["name"], name: "index_messenger_groups_on_name"
  add_index "messenger_groups", ["owner_id", "owner_type"], name: "index_messenger_groups_on_owner_id_and_owner_type"

  create_table "messenger_memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.string   "member_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messenger_memberships", ["group_id"], name: "index_messenger_memberships_on_group_id"
  add_index "messenger_memberships", ["member_id", "member_type"], name: "imm"
  add_index "messenger_memberships", ["member_type"], name: "index_messenger_memberships_on_member_type"

  create_table "messenger_messages", force: true do |t|
    t.text     "body"
    t.string   "subject"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messenger_messages", ["sender_id", "sender_type"], name: "index_messenger_messages_on_sender_id_and_sender_type"

  create_table "messenger_receipts", force: true do |t|
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messenger_receipts", ["message_id", "recipient_id", "recipient_type"], name: "mrr"
  add_index "messenger_receipts", ["message_id"], name: "index_messenger_receipts_on_message_id"
  add_index "messenger_receipts", ["recipient_id", "recipient_type"], name: "index_messenger_receipts_on_recipient_id_and_recipient_type"

  create_table "users", force: true do |t|
    t.string "name"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
