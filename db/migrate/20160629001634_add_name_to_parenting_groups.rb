class AddNameToParentingGroups < ActiveRecord::Migration
  def change
    add_column :parenting_groups, :name, :string
  end
end
