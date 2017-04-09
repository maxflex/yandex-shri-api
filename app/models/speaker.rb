class Speaker < ApplicationRecord
  has_many :lectures, -> { order(:date) }
end
