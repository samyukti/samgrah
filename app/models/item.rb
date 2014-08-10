class Item < ActiveRecord::Base
  include MasterConcerns

  mount_uploader :photo, ImageUploader

  belongs_to :category

  has_many :item_creators, dependent: :destroy
  has_many :copies, dependent: :restrict_with_error
  has_many :issues, dependent: :restrict_with_error
  has_many :reservations, dependent: :restrict_with_error

  accepts_nested_attributes_for :item_creators, reject_if: proc { |ic| ic[:creator_id].blank? }, allow_destroy: true

  validates_presence_of :code, :name, :kind, :format, :language, :category_id
  validates_uniqueness_of :code

  def creator
    self.item_creators.first.creator if self.item_creators.first
  end

  def available_quantity
    self.copies.map(&:available_quantity).reduce(:+)
  end
end
