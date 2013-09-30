class RegistrationsController < Devise::RegistrationsController

  def create
    if verify_recaptcha ||
      (!session['devise.user_attributes'].nil? && !session['devise.user_attributes']['provider'].nil?) ||
      Rails.env.development?
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

  protected

  # Overrides devise's redirect path after the user is updated. The path defined here is the same as the page the
  # user is editing.
  def after_update_path_for(resource)
    edit_user_registration_path
  end

end
