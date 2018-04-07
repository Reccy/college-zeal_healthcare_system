class AddDepartmentHeadToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_reference :departments, :department_head, foreign_key: {to_table: :doctors}
  end
end
