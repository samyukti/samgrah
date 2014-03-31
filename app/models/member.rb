class Member < ActiveRecord::Base
  include MasterConcerns

  mount_uploader :photo, MemberUploader

  belongs_to :membership

  has_one :address, as: :addressable, dependent: :destroy
  has_many :issues, dependent: :restrict_with_error
  has_many :reservations, dependent: :restrict_with_error

  accepts_nested_attributes_for :address, allow_destroy: true

  validates_presence_of :code, :name, :membership_id
  validates_uniqueness_of :code
end
