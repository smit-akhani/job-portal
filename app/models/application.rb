class Application < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_one_attached :resume
end
