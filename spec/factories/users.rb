FactoryGirl.define do
  factory :user do
    name 'Jane Doe'
    email 'jane.doe@example.com'
    encrypted_password '7b199f5e0ea0b715525e1f3c55cb276a'
    reset_password_token '578fcf68d69d6368cd407da7e3b0c0dd'
    reset_password_sent_at '2014-01-01'
    remember_created_at '2014-01-01'
    sign_in_count 1
    current_sign_in_at '2014-01-01 01:01:01.000001'
    last_sign_in_at '2014-01-01 01:01:01.000001'
    current_sign_in_ip '127.0.0.1'
    last_sign_in_ip '127.0.0.1'
    notes 'This is a test user record'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
