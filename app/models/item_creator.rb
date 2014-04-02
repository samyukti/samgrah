class ItemCreator < ActiveRecord::Base
  belongs_to :creator
  belongs_to :item

  validates_presence_of :creator_id, :role

  default_scope { order('sequence asc') }
end
