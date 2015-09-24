class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
    	t.string :name
    	t.integer :total_hours

      	t.timestamps null: false
    end
  end
end
