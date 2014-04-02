FactoryGirl.define do
  factory :item_creator do
    item_id 1
    creator_id 1
    sequence 1
    role 'author'
    created_by 1
    updated_by 1
  end
end
