class ApplicationController < ActionController::Base
  before_action :authorize_role_and_resource
  skip_before_action :authorize_role_and_resource, if: :devise_controller?

  private

  def authorize_role_and_resource
    print "WHERE IS THIS MESSAGE: #{current_user.inspect}" # Debugging log to see the current_user object
  
    # Check if current_user exists to avoid errors
    unless current_user
      redirect_to new_user_session_path, alert: "You must be signed in to access this resource."
      return
    end
  
    if current_user.role == "ADMIN"
      return # Admins can do anything; allow access
    elsif current_user.role == "WRITER"
      # Check resource ownership
      if resource_belongs_to_user?
        return # Allow access
      else
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    else
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def resource_belongs_to_user?
    # Check if the current user owns the resource
    resource = find_resource
    resource.respond_to?(:user_id) && resource.user_id == current_user.id
  end

  def find_resource
    params.each do |key, value|
      if key.end_with?("_id")
        return key.classify.constantize.find_by(id: value)
      end
    end
    nil
  end
end
