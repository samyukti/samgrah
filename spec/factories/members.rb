FactoryGirl.define do
  factory :member do
    membership_id 1
    code 'M10001'
    name 'John Doe'
    kind 'Person'
    gender 'Male'
    age_group 'Middle'
    notes 'This is a test member record'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
