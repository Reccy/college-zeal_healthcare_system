class AddValidationsToDepartment < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :departments, :name, false
  end
end
