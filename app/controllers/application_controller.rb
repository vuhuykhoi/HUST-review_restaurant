class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale
  
  def set_locale
  locale = params[:locale].to_s.strip.to_sym
  I18n.locale = I18n.available_locales.include?(locale) ?
    locale : I18n.default_locale
  end
  
  def default_url_options
  {locale: I18n.locale}
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up,keys: [:id,:name,:email,:password,:birthday]
    
    devise_parameter_sanitizer.permit :account_update,keys: [:name,:email,:birthday,:photo,:password]
  end
end