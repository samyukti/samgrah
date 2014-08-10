class Copy < ActiveRecord::Base
  include MasterConcerns
  include DataQuality

  mount_uploader :photo, ImageUploader

  belongs_to :item

  has_many :issues, dependent: :restrict_with_error

  validates_presence_of :name, :quality, :status, :item_id
  validates_uniqueness_of :name
  validate :valid_procured_date
  validate :copywise_issuable
  validate :return_before_change_status

  after_initialize :init_procured_date
  before_create :set_quantity
  before_save :set_item_attributes

  def issuable?
    self.issuable == true
  end

  def available
    where(issuable: true).
    where(status: 'available').
    where('copies.quantity > (copies.issued_quantity + copies.adjusted_quantity)')
  end

  def issued
    self.issued_quantity == (self.quantity - self.adjusted_quantity)
  end

  def available_quantity
    self.quantity - (self.issued_quantity + self.adjusted_quantity)
  end

  def image_url(version = nil)
    version &&= version.to_sym
    self.photo.blank? && self.item.photo.present? ? self.item.photo.url(version) : self.photo.url(version)
  end

  private

  def valid_procured_date
    errors.add(:procured_date, 'Procured date should not be in future.') \
      if procured_date && self.procured_date > Date.today
  end

  def copywise_issuable
    errors.add(:quantity, 'Copy-wise Issuable items should be 1 per copy') \
      if self.issuable? && self.item && self.item.copywise && self.quantity != 1
  end

  def return_before_change_status
    errors.add(:status, 'Return the item before the changing the status') \
      if self.status_was != self.status && self.issued_quantity > 0
  end

  def init_procured_date
    self.procured_date ||= Date.today
  end

  def set_quantity
    self.quantity ||= 1
  end

  def set_item_attributes
    self.format         = either self.format,         or: self.item.format
    self.length         = either self.length,         or: self.item.length
    self.length_uom     = either self.length_uom,     or: self.item.length_uom
    self.publisher      = either self.publisher,      or: self.item.publisher
    self.published_date = either self.published_date, or: self.item.published_date
    self.cost           = either self.cost,           or: self.item.cost
    self.price          = either self.price,          or: self.item.price
  end
end
