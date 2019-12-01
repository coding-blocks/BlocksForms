class Section < ApplicationRecord
  belongs_to :form
  has_many :questions
end
