class AddForeignKeyForConflict1InNegotiations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :negotiations, :conflicts, column: :conflict1_id, validate: false
  end
end
