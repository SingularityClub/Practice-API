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

ActiveRecord::Schema.define(version: 20150102073455) do

  create_table "articles", force: true do |t|
    t.string   "title",                        null: false
    t.text     "content"
    t.integer  "views",         default: 0,    null: false
    t.boolean  "enable",        default: true, null: false
    t.integer  "comment_count", default: 0,    null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "articles_tags", id: false, force: true do |t|
    t.integer "article_id", null: false
    t.integer "tag_id",     null: false
  end

  create_table "comments", force: true do |t|
    t.string   "content",           limit: 6000,                null: false
    t.integer  "up",                             default: 0,    null: false
    t.integer  "down",                           default: 0,    null: false
    t.boolean  "enable",                         default: true, null: false
    t.string   "ip"
    t.integer  "o_auth_account_id"
    t.integer  "comment_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"
  add_index "comments", ["comment_id"], name: "index_comments_on_comment_id"
  add_index "comments", ["o_auth_account_id"], name: "index_comments_on_o_auth_account_id"

  create_table "o_auth_accounts", force: true do |t|
    t.string   "idstr"
    t.string   "screen_name"
    t.string   "name"
    t.string   "url"
    t.string   "profile_image_url"
    t.string   "gender"
    t.string   "avatar_large"
    t.string   "avatar_hd"
    t.string   "lang"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "title",                     null: false
    t.string   "icon"
    t.boolean  "enable",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",           limit: 32,                null: false
    t.string   "name"
    t.string   "encrypted_password",                           null: false
    t.string   "email"
    t.string   "salt",                                         null: false
    t.integer  "gender",                        default: 0
    t.boolean  "enable",                        default: true, null: false
    t.integer  "o_auth_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["o_auth_account_id"], name: "index_users_on_o_auth_account_id"

end
