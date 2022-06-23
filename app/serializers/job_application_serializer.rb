class JobApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,:status ,:apply_date,:feedback,:user_resume_url, :custom_name, :custom_title, :custom_profile

  def custom_profile
    rails_blob_path(object.user.user_detail.avatar , only_path: true) if object.user.user_detail.avatar.attached?
  end
  
  def custom_name
    object.user.user_detail.name
  end

  def custom_title
    object.job.job_title
  end
end
