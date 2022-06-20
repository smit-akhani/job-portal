class CompanyDetail < ApplicationRecord
  belongs_to :company
  has_one :address, as: :addressable, dependent: :destroy
  has_one_attached :logo
  has_one_attached :banner
  has_many_attached :images
  accepts_nested_attributes_for :address, update_only: true
end
