class Space < ApplicationRecord
  TYPE_SPACE = ["Desk", "Office", "Meeting Room", "Events Room"]
  belongs_to :user
  belongs_to :rate
  has_many :listings
  has_many :bookings

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_attachment :photo
  accepts_nested_attributes_for :rate

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end

end
