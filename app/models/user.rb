class User < ApplicationRecord
	validates :username ,presence: true,  uniqueness: { case_sensitive: false }
	 validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
	 validate :validate_username

	attr_accessor :login
	# accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def login

  	@login || self.username || self.email
  	byebug
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
      	byebug
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
   end
   def validate_username
  if User.where(email: username).exists?
    errors.add(:username, :invalid)
  end
end
end
