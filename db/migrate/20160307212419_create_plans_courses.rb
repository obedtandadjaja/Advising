class CreatePlansCourses < ActiveRecord::Migration
  def change
    create_table :plans_courses do |t|
   	  t.references :plan
      t.references :course
      t.date :taken_on
	  t.string :taken_planned
      t.timestamps null: false
    end
  end
end
