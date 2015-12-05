class CreateUsersCourses < ActiveRecord::Migration
  def change
    create_table :users_courses do |t|
    	t.references :user
    	t.references :course
    	t.date :taken_on
		t.string :taken_planned

      t.timestamps null: false
    end
  end
end
