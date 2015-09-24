class CreateConcentrations < ActiveRecord::Migration
  def change
    create_table :concentrations do |t|
    	t.string :name
    	t.integer :total_hours
    	t.integer :major_id
      	t.timestamps null: false
    end
  end
end
