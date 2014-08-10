# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :adjustment do
    copy_id 1
    item_id 1
    adjusted_date "2014-08-10"
    adjusted_quantity 1
    kind "MyString"
    reason "MyString"
    status "MyString"
    return_date nil
    returned_date nil
    notes "MyText"
    created_by 1
    updated_by 1
  end
end
