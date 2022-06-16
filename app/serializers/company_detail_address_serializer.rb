class CompanyDetailAddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :area, :city, :state, :country, :pincode
end
