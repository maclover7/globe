class AddFieldsToInviteCodes < ActiveRecord::Migration
  def change
    add_column :invite_codes, :for_school_admins, :boolean
    add_column :invite_codes, :for_teachers, :boolean
  end
end
