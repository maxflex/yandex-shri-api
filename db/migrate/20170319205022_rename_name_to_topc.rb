class RenameNameToTopc < ActiveRecord::Migration[5.0]
  def change
    rename_column :lectures, :name, :topic
  end
end
