FactoryGirl.define do
  factory :rule do
    category_id nil
    membership_id 1
    mnemonic 'GOLD_CLASS_BOOKS'
    name 'Number of books for Gold Class members'
    value 3
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
