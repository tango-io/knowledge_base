class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true
end
