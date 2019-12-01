class Form < ApplicationRecord
  has_many :sections
  has_many :attempts
end
