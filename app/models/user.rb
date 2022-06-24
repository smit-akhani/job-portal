class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,:confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_one :user_detail,foreign_key: "users_id", dependent: :destroy
  has_many :user_cvs,foreign_key: "users_id",dependent: :destroy
  after_create_commit :create_user_detail
  
  has_many :educations,foreign_key: "user_id",dependent: :destroy
  has_many :experiences,foreign_key: "user_id",dependent: :destroy
  
  has_many :skill_matches, as: :matchable, dependent: :destroy
  
  has_many :skill ,through: "skill_matches", dependent: :destroy
  after_save :update_default_cv

  has_one :job,dependent: :destroy
  has_many :job_managers,dependent: :destroy
  has_many :companys, through: :job_managers
  has_many :save_jobs, dependent: :destroy
  has_many :jobs, through: :save_jobs ,dependent: :destroy
  has_many :job_applications,dependent: :destroy

  private
# TODO check is user creation is working or not from frontend side
  def create_user_detail
    curent_user=User.find_by(email: self.email)
    p curent_user.id
    x=UserDetail.new(user: curent_user)
    p x.save(:validate => false)
  end
  def update_default_cv
=begin
    if(self.is_default==true)
      UserCv.where(users_id: self.id).update_all(is_default: false)
    end
=end
  end
end
