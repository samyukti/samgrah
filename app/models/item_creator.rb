class ItemCreator < ActiveRecord::Base
  belongs_to :creator
  belongs_to :item
end
