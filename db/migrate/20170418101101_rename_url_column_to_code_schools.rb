class RenameUrlColumnToCodeSchools < ActiveRecord::Migration[5.0]
  def change
    rename_column :schools, :url, :code
  end
end
