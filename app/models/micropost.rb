class Micropost < ActiveRecord::Base
  attr_accessible :content, :image
  has_attached_file :image, :styles => { :medium => "700x250>" }
  belongs_to :user

  validates :content, presence: true, length: { maximum: 254 }
  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'

  self.per_page = 13


  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def self.text_search(search)
    if search
      que = search.downcase
      where("content @@ :q", q: que)
    else
      find(:all)
    end
  end
end