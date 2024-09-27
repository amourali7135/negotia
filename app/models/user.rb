class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conflicts, dependent: :destroy
  has_many :issues, through: :conflicts, dependent: :destroy
  # has_many :negotiations, dependent: :destroy
  has_many :negotiations_as_user1, class_name: 'Negotiation', foreign_key: 'user1_id'
  has_many :negotiations_as_user2, class_name: 'Negotiation', foreign_key: 'user2_id'
  has_many :messages, dependent: :destroy
  # has_many :proposals, dependent: :destroy
  has_many :proposals, foreign_key: :proposed_by_id, dependent: :destroy
  has_many :proposal_responses, dependent: :destroy
  has_many :messages

  def all_negotiations
    Negotiation.where("user1_id = ? OR user2_id = ?", id, id)
  end
end
