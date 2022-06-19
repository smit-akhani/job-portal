class SaveJob < ApplicationRecord
    belongs_to :user
    belongs_to :job
end
