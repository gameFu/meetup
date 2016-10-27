class Comment < ApplicationRecord
  belongs_to :meet_up
  belongs_to :user
  validates :content, presence: true
end
