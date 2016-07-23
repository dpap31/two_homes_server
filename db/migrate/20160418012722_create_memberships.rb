class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id, :null => false
      t.integer :parenting_group_id, :null => false
      t.timestamps null: false
    end
  end
end
