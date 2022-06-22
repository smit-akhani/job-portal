class Job < ApplicationRecord
    include PgSearch::Model
    attr_accessor :comapny_name 
    belongs_to :user, optional: true 
    belongs_to :company
    has_many :save_jobs, dependent: :destroy
    has_many :users, through: :save_jobs ,dependent: :destroy
    has_many :job_applications
     
    validates :job_title, presence: true 
    validates :job_application_link , presence: true, if: :is_not_easy_apply
    

    #NOTE This search for email search in the database
    pg_search_scope :search_job,
                    against:  [:job_description, :job_title,:location],
                    using: {
                        tsearch: { prefix: true }
                      }
    #   NOTE this earch for the job title in the database 
    pg_search_scope :search_by_title, against: :job_title

    
    has_many :skill_matches, as: :matchable, dependent: :destroy 
    has_many :skill ,through: "skill_matches", dependent: :destroy
    # Job.joins(:skill).where("skills.id in (3,4)")
    # NOTE Job.skill_search_filter([3,9])
    scope :skill_search_filter, ->(skill_set) {joins(:skill).where("skills.id in (?)", skill_set)}
    
    def comapny_name
        self.company.email
    end
    def is_not_easy_apply
        self.easy_apply==false 
    end
end
