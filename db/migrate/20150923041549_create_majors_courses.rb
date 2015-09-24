class CreateMajorsCourses < ActiveRecord::Migration
  def change
    create_table :majors_courses do |t|
    	t.references :major
    	t.references :course

      t.timestamps null: false
    end
  end
end
