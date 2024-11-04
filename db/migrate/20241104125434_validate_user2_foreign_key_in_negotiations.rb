class ValidateUser2ForeignKeyInNegotiations < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :negotiations, :users, column: :user2_id
  end
end