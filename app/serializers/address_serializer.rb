class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :area, :city, :state, :country, :pincode
  belongs_to :addressable, polymorphic: true
end
