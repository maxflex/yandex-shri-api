json.array! @lectures do |lecture|
  json.extract! lecture, :id, :topic, :date, :time_start, :time_end
  json.speaker lecture.speaker, :id, :name, :workplace
  json.auditorium lecture.auditorium, :name
  json.schools lecture.schools, :id, :name
  json.conducted lecture.material != nil
end
