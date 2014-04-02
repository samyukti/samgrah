class Item < ActiveRecord::Base
  include MasterConcerns

  mount_uploader :photo, ImageUploader

  belongs_to :category

  has_many :item_creators, dependent: :destroy
  has_many :copies, dependent: :restrict_with_error
  has_many :issues, dependent: :restrict_with_error
  has_many :reservations, dependent: :restrict_with_error

  accepts_nested_attributes_for :item_creators, reject_if: proc { |ic| ic[:creator_id].blank? }

  validates_presence_of :code, :name, :kind, :format, :language, :category_id
  validates_uniqueness_of :code
  validate :at_least_one_creator

  def creator
    self.item_creators.first.creator
  end

private

  def at_least_one_creator
    errors.add(:base, 'Please add at least one item creator.') \
      if self.item_creators.select { |ic| ic[:creator_id].present? }.count < 1
  end
end
