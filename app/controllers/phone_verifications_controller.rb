class PhoneVerificationsController < ApplicationController
	def new
		
	end

	def create
		session[:mobile_no] = params[:mobile_no]
		session[:country_code] = params[:country_code]
		@response = Authy::PhoneVerification.start(
			via: params[:method],
			county_code: params[:country_code],
			mobile_no: params[:mobile_no])
		if @rsponse.ok?
			redirect_to challenge_phone_verifications_path
		else
			render 'new'
		end
	end

	def verify
		@response = Authy::PhoneVerification.check(
			verification_code: params[:code],
			country_code: session[:country_code],
			mobile_no: params[:mobile_no]
			)
		if @response.ok?
			session[:mobile_number] = nil
			session[:country_code] = nil
			redirect_to root_path
		else
			render 'challenge'
		end

	end
end
