class User < ActiveRecord::Base
  include MasterConcerns
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
end
