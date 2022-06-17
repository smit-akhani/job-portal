class UserDetail < ApplicationRecord
    has_one_attached :avatar
    has_one :address, as: :addressable
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    validates :name,:contact_number,:gender,:users_id, :presence => true
    validates :contact_number,:length => { :is => 10 }
end
