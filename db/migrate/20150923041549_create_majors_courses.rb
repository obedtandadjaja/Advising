class CreateMajorsCourses < ActiveRecord::Migration
  def change
    create_table :majors_courses do |t|
    	t.integer :major_id
    	t.integer :course_id

      t.timestamps null: false
    end
  end
end
