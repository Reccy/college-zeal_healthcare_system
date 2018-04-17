class AddDetailsToPatient < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :phone_number, :string
    add_column :patients, :email, :string
    add_column :patients, :address, :string
    add_column :patients, :date_of_birth, :datetime, null: false, default: 20.years.ago
  end
end
