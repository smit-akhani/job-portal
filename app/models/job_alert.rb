class JobAlert < ApplicationRecord
    belongs_to :user
    validates :job_title, presence: true
end
