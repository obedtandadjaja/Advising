class CreateUsersMajors < ActiveRecord::Migration
  def change
    create_table :users_majors do |t|
    	t.references :user
    	t.references :major
      t.timestamps null: false
    end
  end
end
