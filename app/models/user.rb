class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :token, presence: true
  validates :email,
    uniqueness: true,
    format: { with:  /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'Invalid email' }

  has_many :notebooks

  before_create :build_notebook

  def build_notebook
    notebooks.build(name: "#{self.first_name}'s notebook")
  end
end
