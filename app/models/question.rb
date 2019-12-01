class Question < ApplicationRecord
  belongs_to :section
  has_many :options
  has_many :answers
end
