class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  enum status: { unread: 0, read: 1 }

  scope :recent, -> { order(created_at: :desc).limit(10) }
  scope :unread, -> { where(status: :unread) }
end
