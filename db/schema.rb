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

  create_table "articles", force: :cascade do |t|
    t.string   "title",         limit: 255,                null: false
    t.text     "content"
    t.integer  "views",                     default: 0,    null: false
    t.boolean  "enable",                    default: true, null: false
    t.integer  "comment_count",             default: 0,    null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "articles_tags", id: false, force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "tag_id",     null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content",           limit: 6000,                null: false
    t.integer  "up",                             default: 0,    null: false
    t.integer  "down",                           default: 0,    null: false
    t.boolean  "enable",                         default: true, null: false
    t.string   "ip",                limit: 255
    t.integer  "o_auth_account_id"
    t.integer  "comment_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"
  add_index "comments", ["comment_id"], name: "index_comments_on_comment_id"
  add_index "comments", ["o_auth_account_id"], name: "index_comments_on_o_auth_account_id"

  create_table "o_auth_accounts", force: :cascade do |t|
    t.string   "idstr",             limit: 255
    t.string   "screen_name",       limit: 255
    t.string   "name",              limit: 255
    t.string   "url",               limit: 255
    t.string   "profile_image_url", limit: 255
    t.string   "gender",            limit: 255
    t.string   "avatar_large",      limit: 255
    t.string   "avatar_hd",         limit: 255
    t.string   "lang",              limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title",      limit: 255,                null: false
    t.string   "icon",       limit: 255
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",           limit: 32,                 null: false
    t.string   "name",               limit: 255
    t.string   "encrypted_password", limit: 255,                null: false
    t.string   "email",              limit: 255
    t.string   "salt",               limit: 255,                null: false
    t.integer  "gender",                         default: 0
    t.boolean  "enable",                         default: true, null: false
    t.integer  "o_auth_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["o_auth_account_id"], name: "index_users_on_o_auth_account_id"

end
