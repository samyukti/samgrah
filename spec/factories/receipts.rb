FactoryGirl.define do
  factory :receipt do
    member_id 1
    received_date "2014-04-01"
    kind "membership"
    amount "9.99"
    mode "cash"
    status "draft"
    reference_1 "None"
    reference_2 "None"
    reference_3 "None"
    notes "This is a test record for receipt"
    created_by 1
    updated_by 1
  end
end
