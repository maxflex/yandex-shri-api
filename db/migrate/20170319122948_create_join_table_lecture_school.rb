class CreateJoinTableLectureSchool < ActiveRecord::Migration[5.0]
  def change
    create_join_table :lectures, :schools do |t|
      t.index [:lecture_id, :school_id]
      # t.index [:school_id, :lecture_id]
    end
  end
end
