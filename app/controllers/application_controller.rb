class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :public_controllers

  layout :layout_by_resource

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
