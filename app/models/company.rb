class Company < ApplicationRecord
  has_one :company_detail
  has_one :address, through: :company_detail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :jobs, dependent: :destroy
  has_many :job_managers, dependent: :destroy
  has_many :user ,through: :job_managers
end
