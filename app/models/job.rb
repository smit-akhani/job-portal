class Job < ApplicationRecord
    include PgSearch::Model
    attr_accessor :comapny_name 
    belongs_to :user, optional: true 
    belongs_to :company
    has_many :save_jobs, dependent: :destroy
    has_many :users, through: :save_jobs ,dependent: :destroy
    has_many :job_applications
  
    pg_search_scope :search_job,
                    against:  [:job_description, :job_title,:location],
                    using: {
                        tsearch: { prefix: true }
                      }

    has_many :skill_matches, as: :matchable, dependent: :destroy 
    has_many :skill ,through: "skill_matches", dependent: :destroy
                     
    def comapny_name
        self.company.email
    end
end
