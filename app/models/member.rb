class Member < ActiveRecord::Base
  include MasterConcerns

  mount_uploader :photo, MemberUploader

  belongs_to :membership

  has_one :address, as: :addressable, dependent: :destroy
  has_many :issues, dependent: :restrict_with_error
  has_many :reservations, dependent: :restrict_with_error

  accepts_nested_attributes_for :address, allow_destroy: true

  validates_presence_of :code, :name, :kind, :membership_id
  validates_uniqueness_of :code
  validate :enrolment_dates

  private

  def enrolment_dates
    errors.add(:closed_date, 'Closed date should be greater than or equal to join date.') \
      if self.join_date && self.closed_date && self.closed_date < self.join_date
    errors.add(:renewal_date, 'Renewal date should be greater than or equal to last renewed date.') \
      if self.renewal_date && self.renewed_date && self.renewal_date < self.renewed_date
    errors.add(:renewed_date, 'Renewal date should be greater than or equal to join date.') \
      if self.join_date && self.renewed_date && self.renewed_date < self.join_date
    errors.add(:renewal_date, 'Renewal date should be greater than or equal to join date.') \
      if self.join_date && self.renewal_date && self.renewal_date < self.join_date
  end
end
