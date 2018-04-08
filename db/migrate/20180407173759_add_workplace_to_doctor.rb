class AddWorkplaceToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_reference :doctors, :workplace, foreign_key: {to_table: :departments}
  end
end
