json.extract! @lecture, :topic, :students_count, :date, :time_start, :time_end
json.speaker @lecture.speaker, :id, :name, :workplace, :description, :photo_url
json.auditorium @lecture.auditorium, :name, :capacity, :address
json.schools @lecture.schools, :name
json.material @lecture.material, :link, :video
