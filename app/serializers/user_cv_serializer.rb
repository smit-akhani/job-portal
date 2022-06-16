class UserCvSerializer < ActiveModel::Serializer
  attributes :id, :is_default, :cv_url,:title
end
