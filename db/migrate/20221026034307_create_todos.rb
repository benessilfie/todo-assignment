class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :description, null:false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
