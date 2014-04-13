FactoryGirl.define do
  factory :membership do
    code 'MS10001'
    name 'Gold Class'
    kind 'premium'
    notes 'This is a test membership record'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
