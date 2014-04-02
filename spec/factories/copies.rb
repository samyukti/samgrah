FactoryGirl.define do
  factory :copy do
    item_id 1
    name 'P-1022013912-BP-01'
    procured_date '2014-01-01'
    status 'a'
    length 208
    length_uom 'Pages'
    cost 10.0
    price 10.0
    quality 'n'
    quantity 1
    issuable true
    issued false
    photo 'item.jpg'
    remote_photo_url nil
    notes 'This is a test copy record'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
