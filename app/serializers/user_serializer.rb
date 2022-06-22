class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :skill
  has_one :user_detail
  has_many :experiences
  has_many :educations
end
