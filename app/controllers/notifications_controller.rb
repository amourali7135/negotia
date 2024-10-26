class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.recent
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.read!
    redirect_back(fallback_location: notifications_path)
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(status: :read)
    redirect_back(fallback_location: notifications_path)
  end
end
