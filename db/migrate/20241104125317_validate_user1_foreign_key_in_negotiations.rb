class ValidateUser1ForeignKeyInNegotiations < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :negotiations, :users, column: :user1_id
  end
end
