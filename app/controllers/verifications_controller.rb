class VerificationsController < ApplicationController
	skip_before_action :verify_user!
 
  def edit
  end
 
  def update
  confirmation = Nexmo::Client.new.verify.check(

    request_id: params[:id],
    code: params[:code]
  )
  if confirmation['status'] == '0'
    session[:verified] = true
    redirect_to :root, flash: { success: 'Welcome back.' }
  else
    
    render plain: "OK"
    # redirect_to edit_verifications_path(id: params[:id]), flash: { error: confirmation['error_text'] }
  end
end
end
