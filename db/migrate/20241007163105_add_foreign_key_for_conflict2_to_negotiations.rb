class AddForeignKeyForConflict2ToNegotiations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :negotiations, :conflicts, column: :conflict2_id
  end
end
