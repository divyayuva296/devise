class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :verify_user!, unless: :devise_controller?
 
	

	protected
	def configure_permitted_parameters
		# devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:password, :mobile_no,:remember_me,:email,:password_confirmation,role: []])

		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    		user_params.permit(:role,:username, :email,:login,:mobile_no,:password_confirmation,:password)
  		end
  		devise_parameter_sanitizer.permit(:account_update, keys: [:role,:username,:email,:login,:password,:password_confirmation,:mobile_no])
  		
	end

	def verify_user!
  		start_verification if requires_verification?
  		# byebug
	end

	def requires_verification?
  		session[:verified].nil? && !current_user.mobile_no.blank?
	end

	# def start_verification
	#clien 	# byebug
	# 	client = Nexmo::Client.new(api_key: '4ddb8ed8', api_secret: 'rcCfReebOaqs9urN')
 #  		result = client.verify.request(
 #    		number: current_user.mobile_no,
 #    		brand: "Vonage",
 #    		sender_id: 'Kittens',
 #    		code_length: '4'
 #  			)
 #  		if result['status'] == '0'
 #    		redirect_to edit_verification_path(id: result['request_id'])
 #  		else
 #    		sign_out current_user
 #    		redirect_to :new_user_session, flash: {
 #      		error: 'Could not verify your number. Please contact support.'
 #    		}
 #  		end
	# end
	# def start_verification
	# 	client = Vonage::Client.new(api_key: "4ddb8ed8",api_secret: "rcCfReebOaqs9urN")
	# 	response = client.verify.request(number: current_user.mobile_no,)
	# end
	def start_verification
		client = Nexmo::Client.new(api_key: "4ddb8ed8",api_secret: "rcCfReebOaqs9urN")
# client = Vonage::Client.new(api_key: "4ddb8ed8",api_secret: "rcCfReebOaqs9urN")

		response = client.verify.request(
			number: current_user.mobile_no,
			country: 'IN',
			brand: 'MyDevise',
			code_length: '4'
			)

			if response.status == '0'
				redirect_to edit_verification_path(id: response['request_id'])
			else
				sign_out current_user
				redirect_to :new_user_session, flash: {
      				error: 'Could not verify your number. Please contact support.'
    				}
			end
# 		
	end

 






end
