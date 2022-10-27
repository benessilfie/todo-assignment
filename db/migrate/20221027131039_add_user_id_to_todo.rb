class AddUserIdToTodo < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :user_id, :integer

    add_foreign_key :todos, :users, column: :user_id
  end
end
 