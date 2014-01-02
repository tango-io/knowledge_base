class Document < ActiveRecord::Base
  validates_presence_of :title
  acts_as_taggable
  acts_as_taggable_on :tag_list
end
