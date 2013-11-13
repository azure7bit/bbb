class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :code, :name, :unit

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true
end