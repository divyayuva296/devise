class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:password, :remember_me])

		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    user_params.permit(:username, :email,:login)
  end
	end



end
