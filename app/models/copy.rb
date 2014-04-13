class Copy < ActiveRecord::Base
  include MasterConcerns

  mount_uploader :photo, ImageUploader

  belongs_to :item

  has_many :issues, dependent: :restrict_with_error

  validates_presence_of :name, :quality, :status, :item_id
  validates_uniqueness_of :name
  validate :valid_procured_date
  validate :unit_quantity_is_issuable
  validate :return_before_change_status

  scope :available, -> { where(status: 'available', issuable: true, issued: false) }

  after_initialize :init_procured_date
  before_create :set_quantity

  def issuable?
    self.issuable == true
  end

  def issued?
    self.issued == true
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

  def unit_quantity_is_issuable
    errors.add(:quantity, 'Issuable items should be 1 per copy') \
      if self.issuable? && quantity != 1
  end

  def return_before_change_status
    errors.add(:status, 'Return the book before the changing the status') \
      if self.status_was != self.status && self.issued?
  end

  def init_procured_date
    self.procured_date ||= Date.today
  end

  def set_quantity
    self.quantity ||= 1
  end
end
