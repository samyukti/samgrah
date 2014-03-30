FactoryGirl.define do
  factory :item do
    category_id 1
    code 'B10001'
    name 'Pride and Prejudice'
    creator_id 1
    subject 'Novel of Manners'
    kind 'Book'
    format 'Paperback'
    pages 208
    publisher 'Whitehall'
    published_date '28-01-1813'
    language 'English'
    isbn_10 '1234567890'
    isbn_13 '1234567890123'
    reference 'This is a test book'
    rights 'Public Domain'
    rating 10
    tags 'classics, satire'
    excerpt 'Pride and Prejudice is a novel of manners by Jane Austen, first published in 1813'
    notes 'One of the most popular novels in English literature'
    active true
    archived false
    created_by 1
    updated_by 1
  end
end
