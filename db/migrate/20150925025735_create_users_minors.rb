class CreateUsersMinors < ActiveRecord::Migration
  def change
    create_table :users_minors do |t|
    	t.references :user
    	t.references :minor
    	
      t.timestamps null: false
    end
  end
end
