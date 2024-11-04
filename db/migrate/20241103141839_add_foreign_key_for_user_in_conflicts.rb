class AddForeignKeyForUserInConflicts < ActiveRecord::Migration[7.0]
  def change
    # Adds foreign key without immediate validation
    add_foreign_key :conflicts, :users, column: :user_id, validate: false
  end
end


