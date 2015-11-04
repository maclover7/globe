class CreateCourseNotifications < ActiveRecord::Migration
  def change
    create_table :course_notifications do |t|
      t.text :body
      t.integer :course_id
      t.string :subject

      t.timestamps null: false
    end
  end
end
