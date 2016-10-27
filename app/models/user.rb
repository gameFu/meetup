class User < ApplicationRecord
  include JsonWebTokenAble
  has_many :meet_ups
  has_many :comments
  has_secure_password
  validates :name, presence: true
  validates :password, length: { minimum: 6 }
end
