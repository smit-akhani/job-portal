class JobSerializer < ActiveModel::Serializer
  attributes :id,:job_description,:job_title,:year_of_exp,:location,:last_date_to_apply,:easy_apply,:job_application_link
  has_many :skill
end
