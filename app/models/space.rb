class Space < ApplicationRecord
  TYPE_SPACE = ["Desk", "Office", "Meeting Room", "Events Room"]
  belongs_to :user
  belongs_to :rate
  has_many :listings

  has_attachment :photo
  accepts_nested_attributes_for :rate
end
