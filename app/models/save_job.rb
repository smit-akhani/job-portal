class SaveJob < ApplicationRecord
    belongs_to :user
    belongs_to :job
    attr_accessor :skill_list 
    def skill_list
        self.job.skill.all
    end
end
