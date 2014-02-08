class Event < ActiveRecord::Base
  has_many :user
  
  default_scope -> { order('created_at DESC') }
    
  validates :name, presence: true, length: { maximum: 50 }
  validates :event_date, presence: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
end
