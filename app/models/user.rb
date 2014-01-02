class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :token, presence: true
  validates :email,
    uniqueness: true,
    format: { with:  /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'Invalid email' }
end
