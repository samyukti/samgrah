FactoryGirl.define do
  factory :category do
    parent_id nil
    code '1001'
    name 'Classics'
    kind 'fiction'
    notes 'Classical works of fiction'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
