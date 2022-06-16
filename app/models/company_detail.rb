class CompanyDetail < ApplicationRecord
  belongs_to :company
  has_one :address, as: :addressable
  has_one_attached :logo
  has_one_attached :banner
  has_many_attached :images
end
