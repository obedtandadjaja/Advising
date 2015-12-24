class CreateCoursePrerequisites < ActiveRecord::Migration
  def change
    create_table :course_prerequisites do |t|
      t.belongs_to :course
      t.belongs_to :prerequisite, class_name: 'Course'

      t.timestamps null: false
    end
  end
end
