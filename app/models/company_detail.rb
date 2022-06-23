class CompanyDetail < ApplicationRecord
  belongs_to :company
  has_one :address, as: :addressable, dependent: :destroy
  has_one_attached :logo
  has_one_attached :banner
  has_many_attached :images
  # validates :name,:about,:phone, presence: true 
  accepts_nested_attributes_for :address, update_only: true
  attr_accessor :logo_url, :banner_url, :images_url
  def logo_url
    Rails.application.routes.url_helpers.rails_blob_path(self.logo, only_path: true) if  self.logo.attachment
  end
  def banner_url
    Rails.application.routes.url_helpers.rails_blob_path(self.banner, only_path: true) if  self.banner.attachment
  end
  def images_url
  end
end
