class Document < ActiveRecord::Base
  validates_presence_of :title
  acts_as_taggable
  acts_as_taggable_on :tag_list

  scope :search, -> q { where('title ILIKE ?', "%#{q}%") }

  class << self
    def tags
      tag_counts.map do |tag|
        tag.name
      end
    end
  end
end
