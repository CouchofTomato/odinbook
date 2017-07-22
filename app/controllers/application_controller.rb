class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_filter :get_notifications

  private

  def get_notifications
    if current_user
      @notifications = current_user.notifications
    end
  end
end
