class Book < ApplicationRecord
  validates :ISBN13, presence: true, uniqueness: true
end
