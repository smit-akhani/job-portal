class Job < ApplicationRecord
    belongs_to :user, optional: true 
    belongs_to :company
    has_many :save_jobs, dependent: :destroy
    has_many :users, through: :save_jobs ,dependent: :destroy
    has_many :job_applications
end
