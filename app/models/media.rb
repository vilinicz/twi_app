class Media < ActiveRecord::Base
  attr_accessible :description, :title

  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true
end
