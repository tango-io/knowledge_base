class Document < ActiveRecord::Base
  belongs_to :notebook

  validates_presence_of :title

  acts_as_taggable
  acts_as_taggable_on :tag_list

  scope :search, -> q { where('title ILIKE ?', "%#{q}%") }
  scope :recent_ones, -> { order('created_at DESC').limit(10) }

  class << self
    def tags
      tag_counts.map do |tag|
        tag.name
      end
    end

    def popular_tags
      tag_counts_on(:tags, limit: 10, order: 'count desc')
    end
  end
end
