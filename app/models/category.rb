class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :code, :name, :unit, :is_active

  has_many :items

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true

  def filtering_item(item_id)
  	self.items.find_by_id(item_id)
  end

  def status
    self.is_active ? 'Active' : 'Banned'
  end

  def deactive
    self.update_attributes(:is_active => false)
  end

  def activate
    self.update_attributes(:is_active => true)
  end

  def self.find_next_available_number_for(default=99999)
    self.any? ? (self.maximum(:code, :order => "code") || default).succ : "CT-00001"
  end
end