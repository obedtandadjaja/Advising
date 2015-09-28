class CreateMinors < ActiveRecord::Migration
  def change
    create_table :minors do |t|
    	t.string :name
    	t.integer :total_hours

      t.timestamps null: false
    end
  end
end
