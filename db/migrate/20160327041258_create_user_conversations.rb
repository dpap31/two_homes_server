class CreateUserConversations < ActiveRecord::Migration
  def change
    create_table :user_conversations do |t|
      t.integer :user_id, :null => false
      t.integer :conversation_id, :null => false
      t.timestamps
    end
    add_index :user_conversations, :user_id
    add_index :user_conversations, :conversation_id
  end
end

