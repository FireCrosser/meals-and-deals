class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_one :role

  before_create :set_role

  scope :users_not_empty, -> { select('1').limit(1).count }

  private

  def set_role
    if User.users_not_empty == 0
      self.role_id = 2
    else
      self.role_id = 1
    end
  end
end
