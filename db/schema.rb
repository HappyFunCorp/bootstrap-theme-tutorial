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

ActiveRecord::Schema.define(version: 20151026165707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "crushes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "instagram_user_id"
    t.integer  "crush_user_id"
    t.integer  "comment_count"
    t.integer  "liked_count"
    t.string   "slug"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "main_username"
    t.string   "crush_username"
    t.string   "image_path"
  end

  add_index "crushes", ["slug"], name: "index_crushes_on_slug", unique: true, using: :btree
  add_index "crushes", ["user_id"], name: "index_crushes_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "instagram_comments", force: :cascade do |t|
    t.integer  "instagram_post_id"
    t.integer  "instagram_user_id"
    t.string   "comment"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "instagram_comments", ["instagram_post_id", "instagram_user_id"], name: "comments_post_user", using: :btree

  create_table "instagram_likes", force: :cascade do |t|
    t.integer  "instagram_post_id"
    t.integer  "instagram_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "instagram_likes", ["instagram_post_id", "instagram_user_id"], name: "likes_post_user", using: :btree

  create_table "instagram_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "instagram_user_id"
    t.string   "media_id"
    t.string   "media_type"
    t.integer  "comments_count"
    t.integer  "likes_count"
    t.string   "link"
    t.string   "thumbnail_url"
    t.string   "standard_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "instagram_users", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "profile_picture"
    t.integer  "media_count"
    t.integer  "followed_count"
    t.integer  "following_count"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "instagram_users", ["username"], name: "index_instagram_users_on_username", unique: true, using: :btree

  create_table "report_infos", force: :cascade do |t|
    t.text     "emails"
    t.string   "subject"
    t.text     "models"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_records", force: :cascade do |t|
    t.date     "day"
    t.string   "send_to"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "friend_count"
    t.integer  "fan_count"
    t.integer  "star_count"
    t.integer  "frenemy_count"
    t.datetime "last_synced"
    t.string   "state"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "crushes", "users"
  add_foreign_key "identities", "users"
end
