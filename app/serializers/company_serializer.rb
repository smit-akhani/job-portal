class CompanySerializer < ActiveModel::Serializer
  attributes :id, :email
  has_one :company_detail
end
