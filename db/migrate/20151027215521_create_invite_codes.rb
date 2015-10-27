class CreateInviteCodes < ActiveRecord::Migration
  def change
    create_table :invite_codes do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end
