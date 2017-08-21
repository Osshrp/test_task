class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  check_authorization unless: :devise_controller?
end
