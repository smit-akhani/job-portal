class CompanyDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :about, :phone, :logo, :banner, :images
  has_one :address, as: :addressable, serializer: CompanyDetailAddressSerializer
  belongs_to :company
end
