class RenameLecturersTableToSpeakers < ActiveRecord::Migration[5.0]
  def up
    rename_table :lecturers, :speakers
    rename_column :lectures, :lecturer_id, :speaker_id
  end

  def down
    rename_table :speakers, :lecturers
  end
end
