# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_11_03_141924) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "background_migration_jobs", force: :cascade do |t|
    t.bigint "migration_id", null: false
    t.bigint "min_value", null: false
    t.bigint "max_value", null: false
    t.integer "batch_size", null: false
    t.integer "sub_batch_size", null: false
    t.integer "pause_ms", null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "status", default: "enqueued", null: false
    t.integer "max_attempts", null: false
    t.integer "attempts", default: 0, null: false
    t.string "error_class"
    t.string "error_message"
    t.string "backtrace", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["migration_id", "finished_at"], name: "index_background_migration_jobs_on_finished_at"
    t.index ["migration_id", "max_value"], name: "index_background_migration_jobs_on_max_value"
    t.index ["migration_id", "status", "updated_at"], name: "index_background_migration_jobs_on_updated_at"
  end

  create_table "background_migrations", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "migration_name", null: false
    t.jsonb "arguments", default: [], null: false
    t.string "batch_column_name", null: false
    t.bigint "min_value", null: false
    t.bigint "max_value", null: false
    t.bigint "rows_count"
    t.integer "batch_size", null: false
    t.integer "sub_batch_size", null: false
    t.integer "batch_pause", null: false
    t.integer "sub_batch_pause_ms", null: false
    t.integer "batch_max_attempts", null: false
    t.string "status", default: "enqueued", null: false
    t.string "shard"
    t.boolean "composite", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["migration_name", "arguments", "shard"], name: "index_background_migrations_on_unique_configuration", unique: true
  end

  create_table "background_schema_migrations", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "migration_name", null: false
    t.string "table_name", null: false
    t.string "definition", null: false
    t.string "status", default: "enqueued", null: false
    t.string "shard"
    t.boolean "composite", default: false, null: false
    t.integer "statement_timeout"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer "max_attempts", null: false
    t.integer "attempts", default: 0, null: false
    t.string "error_class"
    t.string "error_message"
    t.string "backtrace", array: true
    t.string "connection_class_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["migration_name", "shard"], name: "index_background_schema_migrations_on_unique_configuration", unique: true
  end

  create_table "conflicts", force: :cascade do |t|
    t.string "title", null: false
    t.text "problem", null: false
    t.integer "status", default: 0, null: false
    t.string "opponent", null: false
    t.integer "priority", default: 0, null: false
    t.integer "conflict_type", default: 0, null: false
    t.text "objective", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conflict_type"], name: "index_conflicts_on_conflict_type"
    t.index ["priority"], name: "index_conflicts_on_priority"
    t.index ["status"], name: "index_conflicts_on_status"
  end

  create_table "issue_analyses", force: :cascade do |t|
    t.text "alternative_solutions"
    t.text "possible_solutions"
    t.text "best_alternative"
    t.text "worst_alternative"
    t.text "desired_outcome"
    t.text "minimum_acceptable_outcome"
    t.text "ideal_outcome"
    t.text "expected_outcome"
    t.text "notes"
    t.integer "difficulty", default: 0, null: false
    t.integer "importance", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "satisfaction_level", default: 0
    t.boolean "is_flexible", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string "title", null: false
    t.integer "priority", default: 0, null: false
    t.text "explanation", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priority"], name: "index_issues_on_priority"
    t.index ["status"], name: "index_issues_on_status"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "negotiation_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["negotiation_id", "created_at"], name: "index_messages_on_negotiation_id_and_created_at"
    t.index ["negotiation_id"], name: "index_messages_on_negotiation_id"
  end

  create_table "negotiations", force: :cascade do |t|
    t.string "user2_email", null: false
    t.string "user2_name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "resolved_at"
    t.datetime "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deadline"], name: "index_negotiations_on_deadline"
    t.index ["status"], name: "index_negotiations_on_status"
    t.index ["user2_email"], name: "index_negotiations_on_user2_email"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "action", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practice_session_outcomes", force: :cascade do |t|
    t.integer "overall_result", null: false
    t.integer "satisfaction_level", null: false
    t.text "lessons_learned", null: false
    t.text "next_steps", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practice_sessions", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposal_responses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status", "created_at"], name: "idx_proposal_responses_by_status_and_date"
    t.index ["user_id", "created_at"], name: "idx_proposal_responses_by_user_and_date"
    t.index ["user_id"], name: "index_proposal_responses_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.text "content", null: false
    t.integer "status", default: 0, null: false
    t.integer "proposal_responses_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "background_migration_jobs", "background_migrations", column: "migration_id", on_delete: :cascade
  add_foreign_key "background_migrations", "background_migrations", column: "parent_id", on_delete: :cascade
  add_foreign_key "background_schema_migrations", "background_schema_migrations", column: "parent_id", on_delete: :cascade
  add_foreign_key "messages", "negotiations"
  add_foreign_key "proposal_responses", "users"
end
