class UserDetailSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes  :name,:id, :contact_number, :gender, :avatar,:custom_profile
  
  def custom_profile
    rails_blob_path(object.avatar , only_path: true) if object.avatar.attached?
  end
end
