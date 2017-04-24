class Lecture < ApplicationRecord
  belongs_to :speaker
  belongs_to :auditorium
  has_one :material
  has_and_belongs_to_many :schools

  # проведённые лекции
  scope :conducted, -> { joins(:material) }

  # фильтры
  scope :school, -> (code) { joins(:schools).where(schools: {code: code}) }
  scope :auditorium_id, -> (auditorium_id) { where(auditorium_id: auditorium_id) }
  scope :date_start, -> (date) { where('date >= ?', date) }
  scope :date_end, -> (date) { where('date <= ?', date) }

  # валидаторы
  validates :topic, :date, :time_start, :time_end, presence: true
  validate :time_end_is_greater_than_time_start, :auditorium_has_enough_capacity,
           :one_lecture_at_a_time

  private

  # время конца лекции должно быть больше времени начала
  def time_end_is_greater_than_time_start
    if time_end.present? && time_start.present? && time_end <= time_start
      errors.add(:time_end, 'should be greater than time start')
    end
  end

  # в выбранной аудитории хватает места
  def auditorium_has_enough_capacity
    if students_count.present? && auditorium_id && auditorium.capacity < students_count
      errors.add(:students_count, "should be less then auditorium capacity (#{auditorium.capacity})")
    end
  end

  # для одной школы не может быть двух лекций одновременно
  def one_lecture_at_a_time
    if time_start.present? && time_end.present? && school_ids.present? && date.present?
      date_start_1 = date + time_start.seconds_since_midnight
      date_end_1 = date + time_end.seconds_since_midnight
      schools.each do |school|
        lectures = Lecture.joins(:schools).where(schools: {id: school.id})
        lectures.each do |lecture|
          date_start_2 = lecture.date + lecture.time_start.seconds_since_midnight
          date_end_2 = lecture.date + lecture.time_end.seconds_since_midnight
          # проверка на пересечение дат
          if ((date_start_1 <= date_end_2) && (date_end_1 >= date_start_2))
            errors.add(:base, school.name + ' already has lecture at this time')
          end
        end
      end
    end
  end
end
