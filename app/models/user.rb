class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :balance, numericality: { greater_than_or_equal_to: 0.0, message: "insufficient"}
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum status: {Pending: 0, Approved: 1, Declined: 2}
  enum role: {trader: 0, admin: 1}

  has_many :user_stocks, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
