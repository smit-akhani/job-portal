class UserDetailSerializer < ActiveModel::Serializer
  attributes  :name,:id, :contact_number, :gender, :avatar
end
