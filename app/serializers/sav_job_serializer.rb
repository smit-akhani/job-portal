class SavJobSerializer < ActiveModel::Serializer
  attributes :id,:skill_list
  has_one :job
  
  
end
