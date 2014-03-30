FactoryGirl.define do
  factory :creator do
    kind 'Author'
    first_name 'Jane'
    middle_name 'Emma'
    last_name 'Austen'
    full_name 'Jane Austen'
    sort_name 'Auste, Jane'
    notes 'English novelist'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
