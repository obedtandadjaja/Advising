class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.string :subject
    	t.integer :course_number
    	t.string :title
		t.string :department_code
		t.integer :cipc_code
    	t.integer :hr_low
		t.integer :hr_high
		t.string :department_desc
    	#t.date :date_offered
    	#t.integer :crn

      t.timestamps null: false
    end
  end
end

