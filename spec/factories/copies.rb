FactoryGirl.define do
  factory :copy do
    item_id 1
    name 'P-1022013912-BP-01'
    procured_date '2014-01-01'
    format 'paperback'
    length 208
    length_uom 'pages'
    publisher 'Whitehall'
    published_date '28-01-1813'
    cost 10.0
    price 10.0
    quality 'new'
    issuable true
    quantity 1
    issued_quantity 0
    adjusted_quantity 0
    status 'available'
    location 'A1'
    photo 'item.jpg'
    remote_photo_url nil
    notes 'This is a test copy record'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
