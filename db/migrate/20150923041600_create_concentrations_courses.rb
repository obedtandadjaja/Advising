class CreateConcentrationsCourses < ActiveRecord::Migration
  def change
    create_table :concentrations_courses do |t|
    	t.references :concentration
    	t.references :course

      t.timestamps null: false
    end
  end
end
