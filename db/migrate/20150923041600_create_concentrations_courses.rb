class CreateConcentrationsCourses < ActiveRecord::Migration
  def change
    create_table :concentrations_courses do |t|
    	t.integer :concentration_id
    	t.integer :course_id

      t.timestamps null: false
    end
  end
end
