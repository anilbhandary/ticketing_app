class Event < ActiveRecord::Base
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  
  default_scope -> { order('created_at DESC') }
    
  validates :name, presence: true, length: { maximum: 50 }
  validates :event_date, presence: true
  validates :description, presence: true, length: { maximum: 200 }
end
