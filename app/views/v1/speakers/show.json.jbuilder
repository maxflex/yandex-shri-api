json.extract! @speaker, :name, :workplace, :description, :photo_url
json.lectures @speaker.lectures do |lecture|
  json.extract! lecture, :id, :topic
  json.conducted lecture.material != nil
end
