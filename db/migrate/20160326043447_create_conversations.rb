class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :parenting_group_id
      t.string :name
      t.timestamps null: false
    end
  end
end
