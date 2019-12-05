class Form < ApplicationRecord
  has_many :sections
  has_many :attempts

  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :attempts_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
