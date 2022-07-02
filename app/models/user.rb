class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :balance, numericality: { greater_than_or_equal_to: 0.0, message: "insufficient"}
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum status: {pending: 0, approved: 1, declined: 2}
  enum role: {trader: 0, admin: 1}

  has_many :user_stocks, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
