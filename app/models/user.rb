class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conflicts, dependent: :destroy
  has_many :issues, through: :conflicts, dependent: :destroy
  has_many :negotiations, dependent: :destroy
end
