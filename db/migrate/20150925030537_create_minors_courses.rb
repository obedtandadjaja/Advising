class CreateMinorsCourses < ActiveRecord::Migration
  def change
    create_table :minors_courses do |t|
    	t.references :minor
    	t.references :course
    	
      t.timestamps null: false
    end
  end
end
