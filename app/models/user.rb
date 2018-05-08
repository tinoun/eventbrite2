class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :created_events, class_name: "Event", foreign_key: :creator_id 
  has_many :event_attendees, foreign_key: "attendee_id"
  has_many :attending_events, through: :event_attendees, source: :event 

  attr_accessor :login 
  
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9 _]*\z/} 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def self.find_first_by_auth_conditions(warden_conditions)

  	conditions = warden_conditions.dup

    if login = conditions.delete(:login)

      where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first

    else

      where(conditions.to_hash).first

  end
end

end
