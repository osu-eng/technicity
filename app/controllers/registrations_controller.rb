class RegistrationsController < Devise::RegistrationsController

  def create
    if verify_recaptcha || (!session['devise.user_attributes'].nil? && !session['devise.user_attributes']['provider'].nil?)
      flash.delete :recaptcha_error
      super
    else
      flash.delete :recaptcha_error
      build_resource
      clean_up_passwords(resource)
      flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
      render :new
    end
  end
end
