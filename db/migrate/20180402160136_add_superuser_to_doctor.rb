class AddSuperuserToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :superuser, :boolean, default: false
  end
end
