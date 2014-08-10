class Issue < ActiveRecord::Base
  include Workflow
  workflow_column :status

  belongs_to :item
  belongs_to :copy
  belongs_to :member

  validates_presence_of :copy_id, :member_id, :issued_date, :return_date
  validate :valid_issued_date, if: proc { |i| i.issued_date.present? }
  validate :valid_return_date, if: proc { |i| i.issued_date.present? && i.return_date.present? }
  validate :availability, if: proc { |i| i.copy.present? && i.copy_id_changed? }
  validate :reservations, if: proc { |i| i.copy.present? && i.copy_id_changed? }
  validate :changed_copy, if: proc { |i| i.copy.present? && i.copy_id_changed? }

  after_initialize :init_dates
  before_save :set_item
  after_create :issue_copy

  scope :open, -> { where(status: :issued) }
  scope :overdue, -> { where('return_date < current_date') }

  workflow do
    state :issued do
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

  def availability
    errors.add(:copy_id, 'This copy is not available for issue. Please review.') \
      if self.copy.issued
  end

  def reservations
    item      = self.copy.item
    reserved  = item.reservations.open.count
    available = item.available_quantity
    errors.add(:copy_id, 'All the copies of this item are reserved.') \
      unless available > reserved
  end

  def changed_copy
    errors.add(:copy_id, 'Copy cannot be changed after issue. Please cancel this issue if there is a mistake.') \
      if copy_id_was && copy_id != copy_id_was
  end

  def valid_issued_date
    errors.add(:issued_date, 'Issue date should not be in future.') \
      if self.issued_date > Date.today
  end

  def valid_return_date
    errors.add(:return_date, 'Return date should be after issued date.') \
      if self.return_date < issued_date
  end

  def issue_copy
    self.copy.update_attributes! issued_quantity: self.copy.issued_quantity + 1
  end

  def return_copy
    self.copy.update_attributes! issued_quantity: self.copy.issued_quantity - 1
  end

  def close
    self.returned_date = Date.today
  end

  def init_dates
    self.issued_date ||= Date.today
    self.return_date ||= Date.today + Settings.issue_period
  end

  def set_item
    self.item = self.copy.item
  end
end
