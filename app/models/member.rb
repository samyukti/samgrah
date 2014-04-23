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
  validate :valid_renewed_date
  validate :valid_renewal_date
  validate :valid_closed_date

  private

  def valid_renewed_date
    errors.add(:renewed_date, 'Renewal date should be greater than or equal to join date.') \
      if self.join_date && self.renewed_date && self.renewed_date < self.join_date
  end

  def valid_renewal_date
    if self.renewal_date
      errors.add(:renewal_date, 'Renewal date should be greater than or equal to last renewed date.') \
         if self.renewed_date && self.renewal_date < self.renewed_date
      errors.add(:renewal_date, 'Renewal date should be greater than or equal to join date.') \
        if self.join_date && self.renewal_date < self.join_date
    end
  end

  def valid_closed_date
    errors.add(:closed_date, 'Closed date should be greater than or equal to join date.') \
      if self.join_date && self.closed_date && self.closed_date < self.join_date
  end
end
