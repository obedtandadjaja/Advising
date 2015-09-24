class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :enrollment_time
      t.integer :major_id
      t.integer :concentration_id

      t.timestamps null: false
    end
  end
end
