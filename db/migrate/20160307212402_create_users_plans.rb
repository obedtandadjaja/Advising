class CreateUsersPlans < ActiveRecord::Migration
  def change
    create_table :users_plans do |t|

      t.timestamps null: false
    end
  end
end
