class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :public_controllers

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to application_root_path, alert: exception.message
  end

  layout :layout_by_resource

protected

  def public_controllers
    [:home].include? params[:controller].to_sym
  end

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "login"
    elsif current_user
      "application"
    else
      "public"
    end
  end
end
