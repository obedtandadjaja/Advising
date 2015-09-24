class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.string :title
    	t.string :subject
    	t.integer :number
    	t.integer :credit
    	t.date :date_offered
    	t.integer :crn

      t.timestamps null: false
    end
  end
end
