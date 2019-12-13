class Question < ApplicationRecord
  belongs_to :section
  has_many :options, dependent: :destroy
  has_many :answers

  accepts_nested_attributes_for :options, reject_if: ->(option) { option[:text].blank? }, allow_destroy: true

  validates :options, presence: { message: "Options for a question can't be empty" }
  validates :text, presence: true, allow_blank: false, length: { minimum: 5 }
  validates :question_type_id, presence: true
  validates :question_type_id, inclusion: { in: QuestionsType.question_type_id, unless: proc { |q| q.question_type_id.blank? } }
  accepts_nested_attributes_for :options, reject_if: ->(option) { option[:text].blank? }, allow_destroy: true
end
