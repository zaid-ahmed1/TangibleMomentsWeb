class AddVisibilityToMemories < ActiveRecord::Migration[7.1]
  def change
    add_column :memories, :visibility, :integer, null: true
  end
end
