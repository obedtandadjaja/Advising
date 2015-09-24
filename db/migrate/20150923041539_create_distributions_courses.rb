class CreateDistributionsCourses < ActiveRecord::Migration
  def change
    create_table :distributions_courses do |t|
    	t.integer :distribution_id
    	t.integer :course_id

      t.timestamps null: false
    end
  end
end
