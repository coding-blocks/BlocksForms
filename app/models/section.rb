class Section < ApplicationRecord
  belongs_to :form
  has_many :questions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 5 }
  accepts_nested_attributes_for :questions, reject_if: ->(question) { question[:text].blank? }, allow_destroy: true
end
