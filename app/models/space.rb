class Space < ApplicationRecord

  include PgSearch
  pg_search_scope :search, against: [:name, :address]

  TYPE_SPACE = ["Desk", "Office", "Meeting Room", "Events Room"]
  belongs_to :user
  belongs_to :rate
  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_attachment :photo
  accepts_nested_attributes_for :rate

end
