class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.belongs_to :doctor, foreign_key: true
      t.belongs_to :patient, foreign_key: true
      t.belongs_to :department, foreign_key: true
      t.string :reason, null: false

      t.timestamps
    end
  end
end
