class AddForeignKeyForUserInPracticeSessions < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :practice_sessions, :users, validate: false
  end
end