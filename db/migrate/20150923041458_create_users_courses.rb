class CreateUsersCourses < ActiveRecord::Migration
  def change
    create_table :users_courses do |t|
    	t.integer :user_id
    	t.integer :course_id
    	t.date :taken_on

      t.timestamps null: false
    end
  end
end
