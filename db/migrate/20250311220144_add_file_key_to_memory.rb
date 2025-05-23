class AddFileKeyToMemory < ActiveRecord::Migration[7.1]
  def change
    add_column :memories, :filekey, :string
  end
end
