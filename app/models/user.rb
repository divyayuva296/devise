class User < ApplicationRecord
	validates :username ,presence: true,  uniqueness: { case_sensitive: false }
	 validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
	 validate :validate_username
	 validates :mobile_no, length: {maximum: 10}
	 after_initialize :create_login, if: :new_record?
	enum role: {admin: 0 , user: 1}
	 after_initialize :set_default_role, :if => :new_record?

	def set_default_role
  	self.role ||= :user
	end

	 
	 # after_create :welcome_email

	attr_accessor :login
	# accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,:lockable
  # def login

  # 	@login || self.username || self.email
  # 	binding.pry
  # end
 
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
end
