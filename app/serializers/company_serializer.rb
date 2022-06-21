class CompanySerializer < ActiveModel::Serializer
  has_one :company_detail
  has_many :jobs
end
