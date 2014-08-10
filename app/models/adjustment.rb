class Adjustment < ActiveRecord::Base
  include Workflow
  workflow_column :status

  belongs_to :copy
  belongs_to :item

  validates_presence_of :copy_id, :adjusted_date
  validate :valid_adjusted_date, if: proc { |r| r.adjusted_date.present? }
  validate :valid_return_date, if: proc { |i| i.adjusted_date.present? && i.return_date.present? }
  validate :availability, if: proc { |i| i.copy.present? && i.copy_id_changed? }
  validate :changed_copy, if: proc { |i| i.copy.present? && i.copy_id_changed? }

  scope :open, -> { where(status: :adjusted) }

  after_initialize :init_adjusted_date
  after_initialize :init_adjusted_quantity
  before_save :set_item
  after_create :adjust_copy

  workflow do
    state :adjusted do
      event :cancel, transitions_to: :canceled
      event :close, transitions_to: :closed
    end
    state :canceled
    state :closed

    after_transition do
      return_copy
    end

    on_error do |error, from, to, event, *args|
      errors[:base] << error
    end
  end

  private

  def adjust_copy
    self.copy.update_attributes! adjusted_quantity: self.copy.adjusted_quantity + self.adjusted_quantity
  end

  def return_copy
    self.copy.update_attributes! adjusted_quantity: self.copy.adjusted_quantity - self.adjusted_quantity
  end

  def availability
    errors.add(:copy_id, 'This copy is not available for adjustment. Please review.') \
      if self.copy.issued
  end

  def changed_copy
    errors.add(:copy_id, 'Copy cannot be changed after adjustment. Please cancel this adjustment if there is a mistake.') \
      if copy_id_was && copy_id != copy_id_was
  end

  def valid_adjusted_date
    errors.add(:adjusted_date, 'Adjustment date should not be in the past.') \
      if self.adjusted_date < Date.today
  end

  def valid_return_date
    errors.add(:return_date, 'Return date should be after adjusted date.') \
      if self.return_date < adjusted_date
  end

  def close
    self.returned_date = Date.today
  end

  def init_adjusted_date
    self.adjusted_date ||= Date.today
  end

  def init_adjusted_quantity
    self.adjusted_quantity ||= 1
  end

  def set_item
    self.item = self.copy.item
  end
end
