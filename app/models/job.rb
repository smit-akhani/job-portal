class Job < ApplicationRecord
    include PgSearch::Model
    attr_accessor :comapny_name 
    belongs_to :user, optional: true 
    belongs_to :company
    has_many :save_jobs, dependent: :destroy
    has_many :users, through: :save_jobs ,dependent: :destroy
    has_many :job_applications
  
    # against: [:job_description, :job_title,:location],
                    
    pg_search_scope :search_job,
                    against:  [:job_description, :job_title,:location],
                    using: {
                        tsearch: { prefix: true }
                      }
                    # ,
                    # using: {
                    #     tsearch: { dictionary: 'english' },
                    #     trigram: {
                    #       only: [:job_description, :job_title,:location]
                    #     }
                    #   }
                    
    # multisearchable against: [:job_description, :job_title]

    def comapny_name
        self.company.email
    end
end
