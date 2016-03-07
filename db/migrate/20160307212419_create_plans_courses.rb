class CreatePlansCourses < ActiveRecord::Migration
  def change
    create_table :plans_courses do |t|

      t.timestamps null: false
    end
  end
end
