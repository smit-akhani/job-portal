class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_one :user_detail,foreign_key: "users_id", dependent: :destroy
  has_many :user_cvs,foreign_key: "users_id",dependent: :destroy
  after_create_commit :create_user_detail

  private
  def create_user_detail
    curent_user=User.find_by(email: self.email)
    p curent_user.id
    x=UserDetail.new(user: curent_user)
    p x.save!
  end
end
