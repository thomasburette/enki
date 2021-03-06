class Tagging < ActiveRecord::Base #:nodoc:
  belongs_to :tag, :counter_cache => true
  belongs_to :taggable, :class_name => 'Post', :foreign_key => 'taggable_id' #:polymorphic => true

  def self.after_destroy
    if Tag.destroy_unused and tag.taggings.count.zero?
      tag.destroy
    end
  end
end
