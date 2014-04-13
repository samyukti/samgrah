FactoryGirl.define do
  factory :creator do
    kind 'author'
    first_name 'Jane'
    middle_name 'Emma'
    last_name 'Austen'
    full_name 'Jane Austen'
    sort_name 'Auste, Jane'
    photo 'item.jpg'
    remote_photo_url nil
    notes 'English novelist'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
