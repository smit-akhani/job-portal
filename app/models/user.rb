class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_one :user_detail,foreign_key: "users_id", dependent: :destroy
  has_many :user_cvs,foreign_key: "users_id",dependent: :destroy
  after_create_commit :create_user_detail
  
  has_many :educations,foreign_key: "user_id",dependent: :destroy
  
  
  has_many :skill_matches, as: :matchable, dependent: :destroy

  has_many :skill ,through: "skill_matches", dependent: :destroy
  after_save :update_default_cv


  private
  def create_user_detail
    curent_user=User.find_by(email: self.email)
    p curent_user.id
    x=UserDetail.new(user: curent_user)
    p x.save(:validate => false)
  end
  def update_default_cv
    if(self.is_default==true)
      UserCv.where(users_id: self.id).update_all(is_default: false)
    end
  end
end
