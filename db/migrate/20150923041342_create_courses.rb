#
#   Copyright 2015 Amy Dewaal and Obed Tandadjaja
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.string :subject
    	t.integer :course_number
    	t.string :title
		  t.string :department_code
		  t.integer :cipc_code
    	t.integer :hr_low
		  t.integer :hr_high
		  t.string :department_desc
    	t.date :date_offered

      t.timestamps null: false
    end

    add_index :courses, [:subject, :course_number], :unique => true
  end
end

