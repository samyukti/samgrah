class Item < ActiveRecord::Base
  include MasterConcerns

  mount_uploader :photo, PhotoUploader

  belongs_to :category
  belongs_to :creator

  has_many :item_creators, dependent: :destroy
  has_many :creators,  through: :item_creators
  has_many :copies, dependent: :restrict_with_error
  has_many :issues, dependent: :restrict_with_error
  has_many :reservations, dependent: :restrict_with_error

  validates_presence_of :code, :name, :kind, :format, :language, :category_id
  validates_uniqueness_of :code
end
