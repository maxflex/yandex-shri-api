class CreateLectures < ActiveRecord::Migration[5.0]
  def change
    create_table :lectures do |t|
      t.references :lecturer, foreign_key: true
      t.references :auditorium, foreign_key: true
      t.string :name
      t.integer :students_count, unsigned: true
      t.date :date
      t.time :time_start
      t.time :time_end
      t.timestamps
    end
  end
end
