class Document
  include Mongoid::Document
  field :title
  field :body

  validates_presence_of :title
end
