class Receipt < ActiveRecord::Base
  include Workflow
  workflow_column :status

  belongs_to :member

  validates_presence_of :member_id, :received_date, :kind, :mode, :amount
  validate :valid_received_date, if: proc { |r| r.received_date.present? }

  after_initialize :init_dates

  scope :approved, -> { where(status: :approved) }

  workflow do
    state :draft do
      event :cancel, transitions_to: :canceled
      event :approve, transitions_to: :approved
    end
    state :canceled
    state :approved

    on_error do |error, from, to, event, *args|
      errors[:base] << error
    end
  end

  private

  def valid_received_date
    errors.add(:received_date, 'Receipt date should not be in future.') \
      if self.received_date > Date.today
  end

  def init_dates
    self.received_date ||= Date.today
  end
end
