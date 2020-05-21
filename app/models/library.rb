class Library < ApplicationRecord
  validates :libid, uniqueness: true
  has_many :library_relationships
  has_many :users, through: :library_relationships
end
