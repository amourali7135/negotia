class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conflicts, dependent: :destroy
  has_many :issues, through: :conflicts, dependent: :destroy
  has_many :negotiations_as_user1, class_name: 'Negotiation', foreign_key: 'user1_id'
  has_many :negotiations_as_user2, class_name: 'Negotiation', foreign_key: 'user2_id'
  has_many :negotiations, ->(user) { where("user1_id = :id OR user2_id = :id", id: user.id) }
  has_many :messages, dependent: :destroy
  has_many :proposals, foreign_key: :proposed_by_id, dependent: :destroy
  has_many :proposal_responses, dependent: :destroy
  has_many :practice_sessions, dependent: :destroy
  has_many :practice_session_outcomes, through: :practice_sessions
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

  # Claude rec.  Get back when needed.
  # has_many :initiated_negotiations, class_name: 'Negotiation', foreign_key: 'user1_id'
  # has_many :received_negotiations, class_name: 'Negotiation', foreign_key: 'user2_id'
  # has_many :negotiations, -> { distinct }, through: :conflicts

  # def all_negotiations
  #   Negotiation.where("user1_id = ? OR user2_id = ?", id, id)
  # end

  def total_practice_sessions
    practice_sessions.count
  end
end
