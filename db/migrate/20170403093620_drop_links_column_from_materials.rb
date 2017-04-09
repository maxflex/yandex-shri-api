class DropLinksColumnFromMaterials < ActiveRecord::Migration[5.0]
  def up
    remove_column :materials, :links
    add_column :materials, :link, :string
  end
end
