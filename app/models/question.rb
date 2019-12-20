class Question < ApplicationRecord
  belongs_to :section
  has_many :answers

  validates :text, presence: true, allow_blank: false, length: { minimum: 5 }
  validates :question_type_id, presence: true
  validates :question_type_id, inclusion: { in: QuestionsType.question_type_id, unless: proc { |q| q.question_type_id.blank? } }
end
