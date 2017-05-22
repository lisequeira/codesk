class Space < ApplicationRecord
  belongs_to :user
  belongs_to :rate
  has_attachment :photo
end
