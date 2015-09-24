class CreateDistributionsCourses < ActiveRecord::Migration
  def change
    create_table :distributions_courses do |t|
    	t.references :distribution
    	t.references :course

      t.timestamps null: false
    end
  end
end
