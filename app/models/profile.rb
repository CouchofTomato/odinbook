class Profile < ApplicationRecord
  validates :firstname, :lastname, :date_of_birth, presence: true

  belongs_to :user
  validates :user, presence: true
end
