class JobApplication < ApplicationRecord
  belongs_to :job
  attr_accessor :user_resume_url
  belongs_to :user
  has_one_attached :resume
  has_one :user_cv

  before_create :set_default_status
  before_create :set_apply_date
  after_create :set_resume

  private
  def user_resume_url
    Rails.application.routes.url_helpers.rails_blob_path(self.resume, only_path: true) if  self.resume.attachment
end

  def set_default_status
    self.status = "Application Received"
  end

  def set_apply_date
    self.apply_date = Time.now
  end

  def set_resume
    self.update_attribute(:resume, UserCv.find(self.user_cv_id).cv_blob)
    p "-----------",self.user_cv_id
  end
end
