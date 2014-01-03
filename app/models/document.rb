class Document < ActiveRecord::Base
  validates_presence_of :title

  def self.search_by_title title
    Document.where('title LIKE ?', "%#{title}%")
  end
end
