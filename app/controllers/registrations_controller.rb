class RegistrationsController < Devise::RegistrationsController

  ## other devise stuff
  protected
  def after_update_path_for(resource)
   	edit_user_registration_path(resource)
  end


end