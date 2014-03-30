FactoryGirl.define do
  factory :address do
    addressable_type 'Member'
    addressable_id 1
    line_1 '11, Booker Street'
    line_2 'W Hampton Ave'
    landmark 'Near Estabrook Park'
    city 'Milwaukee'
    state 'WI'
    postal_code '53217'
    country 'USA'
    mobile '9012345678'
    phone_1 '9012345687'
    phone_2 '9012345867'
    email_1 'john.doe@example.com'
    email_2 'doe.john@example.com'
    created_by 1
    updated_by 1
  end
end
