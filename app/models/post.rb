class Post < ActiveRecord::Base

  validate :is_title_case 
  before_validation :make_title_case 
  belongs_to :author

  #put new code here
  def self.by_author(author_id)
    Post.where(author_id: author_id)
  end

  def self.from_today
    Post.where("created_at < ?", 1.days.ago)
  end

  def self.old_news
    Post.where("created_at > ?", 1.days.ago)
  end

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
