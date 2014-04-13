FactoryGirl.define do
  factory :member do
    membership_id 1
    code 'M10001'
    name 'John Doe'
    kind 'person'
    gender 'male'
    age_group 'middle'
    profession 'Teacher'
    join_date '2014-01-01'
    renewal_date '2030-12-31'
    renewed_date '2014-01-01'
    closed_date nil
    status 'active'
    photo 'member.jpg'
    notes 'This is a test member record'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
