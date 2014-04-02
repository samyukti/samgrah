class Creator < ActiveRecord::Base
  include MasterConcerns

  mount_uploader :photo, PhotoUploader

  has_many :item_creators, dependent: :restrict_with_error
  has_many :items

  validates_presence_of :kind, :sort_name
  validates_uniqueness_of :sort_name

  def name
    self.sort_name
  end
end
