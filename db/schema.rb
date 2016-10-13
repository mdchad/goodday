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

ActiveRecord::Schema.define(version: 20161013060343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beneficiaries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "deadline"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "beneficiary_id"
    t.integer  "user_id"
    t.float    "target_amount"
    t.string   "picture"
    t.index ["beneficiary_id"], name: "index_campaigns_on_beneficiary_id", using: :btree
    t.index ["user_id"], name: "index_campaigns_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "credit_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "card_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id", using: :btree
  end

  create_table "donations", force: :cascade do |t|
    t.float    "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.index ["campaign_id"], name: "index_donations_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_donations_on_user_id", using: :btree
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.float    "target_amount"
    t.float    "penalty_amount"
    t.boolean  "is_goal_validated",       default: false
    t.date     "deadline"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "beneficiary_id"
    t.boolean  "is_goal_completed",       default: false
    t.float    "total_pledged_amount",    default: 0.0
    t.string   "picture"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.index ["beneficiary_id"], name: "index_goals_on_beneficiary_id", using: :btree
    t.index ["cached_votes_down"], name: "index_goals_on_cached_votes_down", using: :btree
    t.index ["cached_votes_score"], name: "index_goals_on_cached_votes_score", using: :btree
    t.index ["cached_votes_total"], name: "index_goals_on_cached_votes_total", using: :btree
    t.index ["cached_votes_up"], name: "index_goals_on_cached_votes_up", using: :btree
    t.index ["cached_weighted_average"], name: "index_goals_on_cached_weighted_average", using: :btree
    t.index ["cached_weighted_score"], name: "index_goals_on_cached_weighted_score", using: :btree
    t.index ["cached_weighted_total"], name: "index_goals_on_cached_weighted_total", using: :btree
    t.index ["user_id"], name: "index_goals_on_user_id", using: :btree
  end

  create_table "pledges", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "goal_id"
    t.string   "card_token"
    t.string   "email"
    t.index ["goal_id"], name: "index_pledges_on_goal_id", using: :btree
    t.index ["user_id"], name: "index_pledges_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "family_name"
    t.boolean  "is_admin"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_hash"
    t.string   "provider_img"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "volunteers", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.index ["campaign_id"], name: "index_volunteers_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_volunteers_on_user_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "campaigns", "beneficiaries"
  add_foreign_key "campaigns", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "donations", "campaigns"
  add_foreign_key "donations", "users"
  add_foreign_key "goals", "beneficiaries"
  add_foreign_key "goals", "users"
  add_foreign_key "pledges", "goals"
  add_foreign_key "pledges", "users"
  add_foreign_key "volunteers", "campaigns"
  add_foreign_key "volunteers", "users"
end
