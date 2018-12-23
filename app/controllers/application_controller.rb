# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in
    redirect_to(login_path) unless logged_in?
  end

  def admin_user
    redirect_to(login_path) unless  !current_user.nil? ||current_user.admin?
  end
end
