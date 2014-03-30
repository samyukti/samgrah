FactoryGirl.define do
  factory :reservation do
    item_id 1
    member_id 1
    reserved_date '2014-01-01'
    status 'reserved'
    notes 'This is a test reservation record'
    created_by 1
    updated_by 1
  end
end
