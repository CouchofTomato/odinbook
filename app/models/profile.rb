class Profile < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  def name
    "#{self.firstname} #{self.lastname}"
  end
end
