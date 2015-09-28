class CreateUsersConcentrations < ActiveRecord::Migration
  def change
    create_table :users_concentrations do |t|
    	t.references :user
    	t.references :concentration
    	
      t.timestamps null: false
    end
  end
end
