class User < ApplicationRecord
  require 'carrierwave/orm/activerecord'
  mount_uploader :avatar, AvatarUploader
	require 'nexmo'
      scope :user_scope, -> {where(User.roles == "admin")}
	# require 'authy'
  # before_create :verification_twillo
  # @countries  = { "United States" => "+1", "Switzerland" => "+41", "India" => "+91" }
	enum country: {"+1" => "United States","+91" => "India"}
  has_many :posts
  has_one_attached :profile
	validates :username ,presence: true,  uniqueness: { case_sensitive: false }
	 # validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
	 # validate :validate_username
	 validates :mobile_no, length: {maximum: 13}
	 after_initialize :create_login, if: :new_record?
	# enum role: {admin: 0 , user: 1}
	enum role: [:user,:admin]
	 after_initialize :set_default_role, :if => :new_record?

	def set_default_role

  	self.role ||= :user
  	# byebug
	end

	 
	 # after_create :welcome_email

	attr_accessor :login
	# accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,:confirmable
  def login=(login)
    @login = login
  end
  def login

  	@login || self.username || self.email
  	
  end
 
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
     	if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR mobile_no = :value" , { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:mobile_no)
        where(conditions.to_h).first
      end
  end

   

  def create_login
    if self.username.blank?
      email = self.email.split(/@/)
      # binding.pry
      login_taken = User.where(:username => email[0]).first
      unless login_taken
        self.username = email[0]
      else    
        self.username = self.email
      end   
    end     
  end


  def validate_username
  	if User.where(email: username).exists?
    	errors.add(:username, :invalid)
  	end
	end

	# def after_confirmation_path_for(resource_name, resource)
 #  	sign_in(resource) # In case you want to sign in the user
 #  	your_new_after_confirmation_path
	# end

	private
	 def welcome_email
  	UserMailer.welcome_email(self).deliver
  	 # UserMailer.with(self).welcome_email.deliver_now
  end
  def verification_twillo
    Authy.api_key = 'a645788536e0d20524620a3f7c8638da'
    Authy.api_uri = 'https://api.authy.com'
    authy = Authy::API.register_user(email: self.email,mobile_no: self.mobile_no )
    byebug
    if authy.ok?
      puts authy.id
    else
      puts authy.errors
    end

  end
end
