class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.references :lecture, foreign_key: true
      t.string :links, array: true, default: []
      t.string :video
    end
  end

  def down
    drop_table :materials
  end
end
