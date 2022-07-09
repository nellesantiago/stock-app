class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        stored_location_for(resource) || dashboard_path
    end

    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

private

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name email password])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email password current_password])
    end
end
