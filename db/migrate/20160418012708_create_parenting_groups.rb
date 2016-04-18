class CreateParentingGroups < ActiveRecord::Migration
  def change
    create_table :parenting_groups do |t|
      t.timestamps null: false
    end
  end
end
