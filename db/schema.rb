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

ActiveRecord::Schema.define(version: 20150108192212) do

  create_table "commits", force: true do |t|
    t.integer  "stack_id",                                null: false
    t.integer  "author_id",                               null: false
    t.integer  "committer_id",                            null: false
    t.string   "sha",          limit: 40,                 null: false
    t.text     "message",                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "detached",                default: false, null: false
    t.datetime "authored_at",                             null: false
    t.datetime "committed_at",                            null: false
    t.integer  "additions",               default: 0
    t.integer  "deletions",               default: 0
  end

  add_index "commits", ["author_id"], name: "index_commits_on_author_id", using: :btree
  add_index "commits", ["committer_id"], name: "index_commits_on_committer_id", using: :btree
  add_index "commits", ["created_at"], name: "index_commits_on_created_at", using: :btree
  add_index "commits", ["stack_id"], name: "index_commits_on_stack_id", using: :btree

  create_table "output_chunks", force: true do |t|
    t.integer  "task_id"
    t.text     "text",       limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "output_chunks", ["task_id"], name: "index_output_chunks_on_task_id", using: :btree

  create_table "stacks", force: true do |t|
    t.string   "repo_name",                                       null: false
    t.string   "repo_owner",                                      null: false
    t.string   "environment",              default: "production", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "branch",                   default: "master",     null: false
    t.string   "deploy_url"
    t.string   "lock_reason"
    t.integer  "tasks_count",              default: 0,            null: false
    t.boolean  "continuous_deployment",    default: false,        null: false
    t.integer  "undeployed_commits_count", default: 0,            null: false
    t.string   "reminder_url"
    t.text     "cached_deploy_spec"
  end

  add_index "stacks", ["repo_owner", "repo_name", "environment"], name: "stack_unicity", unique: true, using: :btree

  create_table "statuses", force: true do |t|
    t.string   "state"
    t.string   "target_url"
    t.text     "description"
    t.string   "context",     default: "default", null: false
    t.integer  "commit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["commit_id"], name: "index_statuses_on_commit_id", using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "stack_id",                            null: false
    t.integer  "since_commit_id",                     null: false
    t.integer  "until_commit_id",                     null: false
    t.string   "status",          default: "pending", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "type"
    t.integer  "parent_id"
    t.boolean  "rolled_up",       default: false,     null: false
    t.integer  "additions",       default: 0
    t.integer  "deletions",       default: 0
    t.text     "definition"
  end

  add_index "tasks", ["rolled_up", "created_at", "status"], name: "index_tasks_on_rolled_up_and_created_at_and_status", using: :btree
  add_index "tasks", ["since_commit_id"], name: "index_tasks_on_since_commit_id", using: :btree
  add_index "tasks", ["stack_id"], name: "index_tasks_on_stack_id", using: :btree
  add_index "tasks", ["until_commit_id"], name: "index_tasks_on_until_commit_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "github_id"
    t.string   "name",       null: false
    t.string   "email"
    t.string   "login"
    t.string   "api_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_url"
  end

  create_table "webhooks", force: true do |t|
    t.integer  "stack_id",   null: false
    t.integer  "github_id"
    t.string   "event"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secret"
  end

end
