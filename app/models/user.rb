# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :avatar, :email, :password, :password_confirmation
  has_secure_password

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships

  has_attached_file :avatar, 
                    :styles => { :medium => "150x150>", :thumb => "54x54", :mini => "30x30" },
                    :url  => "/assets/avatars/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def self.text_search(search)
    if search
      que = search.downcase
      where("name @@ :q", q: que)
    else
      find(:all)
    end
  end


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end