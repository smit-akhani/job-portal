class JobSerializer < ActiveModel::Serializer
  attributes :id,:job_description,:job_title,:year_of_exp,:location,:last_date_to_apply,:easy_apply,:job_application_link,:company_detail
  has_many :skill
  # has_one :company
end
