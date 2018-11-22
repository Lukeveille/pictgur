class Picture < ApplicationRecord
  belongs_to :user

  validates :artist, presence: true

  validates :title, length: { minimum: 3, maximum: 40 }

  validates :url, presence: true, uniqueness: true

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.created_after(time)
    Picture.where("created_at > ?", time)
  end

  def self.pictures_created_in_year(year)
    Picture.where(created_at: Date.new(year,1,1)..Date.new(year,-1,-1))
  end
end
