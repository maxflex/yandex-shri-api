class CreateLecturers < ActiveRecord::Migration[5.0]
  def change
    create_table :lecturers do |t|
      t.string :name
      t.string :workplace
      t.string :description
      t.string :photo_url

      t.timestamps
    end
  end
end
