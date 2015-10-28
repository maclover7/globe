class AddSchoolAdminToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :admin, :tech_admin
    add_column :users, :school_admin, :boolean, default: :false
  end
end
