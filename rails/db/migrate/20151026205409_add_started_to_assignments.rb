class AddStartedToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :started, :boolean, default: false
  end
end
