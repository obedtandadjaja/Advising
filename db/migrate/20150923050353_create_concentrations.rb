class CreateConcentrations < ActiveRecord::Migration
  def change
    create_table :concentrations do |t|
    	t.string :name
    	t.integer :total_hours
    	t.references :major
      	t.timestamps null: false
    end
  end
end
