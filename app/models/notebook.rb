class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many   :documents

  validates :name, :user, presence: true
end
