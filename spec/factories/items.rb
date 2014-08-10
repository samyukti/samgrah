FactoryGirl.define do
  factory :item do
    category_id 1
    code 'B10001'
    name 'Pride and Prejudice'
    alt_name 'Pride and Prejudice'
    subject 'Novel of Manners'
    kind 'book'
    format 'paperback'
    length 208
    length_uom 'pages'
    publisher 'Whitehall'
    published_date '28-01-1813'
    language 'english'
    isbn_10 '1234567890'
    isbn_13 '1234567890123'
    cost 10.0
    price 10.0
    reference 'This is a test book'
    rights 'public_domain'
    rating 10
    tags 'classics, satire'
    excerpt 'Pride and Prejudice is a novel of manners by Jane Austen, first published in 1813'
    photo 'item.jpg'
    remote_photo_url nil
    copywise true
    notes 'One of the most popular novels in English literature'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
