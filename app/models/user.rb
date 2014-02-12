class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :gender, presence: true
  validates :password, length: { minimum: 6 }
  
  
  has_secure_password
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def attending?(event)
    self.user_events.find_by(event_id: event.id)
  end
  
  def attend!(event)
    self.user_events.create!(event_id: event.id)
  end
  
  def unattend!(event)
    self.user_events.find_by(event_id: event.id).destroy
  end
  
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
