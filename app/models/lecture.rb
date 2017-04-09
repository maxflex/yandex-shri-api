class Lecture < ApplicationRecord
  belongs_to :speaker
  belongs_to :auditorium
  has_one :material
  has_and_belongs_to_many :schools

  # проведённые лекции
  scope :conducted, -> { joins(:material) }
end
