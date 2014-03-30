FactoryGirl.define do
  factory :issue do
    copy_id 1
    item_id 1
    member_id 1
    issued_date '2014-01-31'
    kind 'short_term'
    status 'issued'
    return_date '2014-01-31'
    returned_date nil
    extension 1
    notes 'This is a test issue record'
    created_by 1
    updated_by 1
  end
end
