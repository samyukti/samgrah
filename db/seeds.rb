# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'Seeding Default Users...'
User.create! email: 'admin@sangrah.local', password: 'samyukti', password_confirmation: 'samyukti'

puts 'Seeding Demo Data...'
y01 = Category.create! code: '1001', name: 'Classics', kind: 'Literature'

r01 = Creator.create! kind: 'Author', first_name: 'Jane', last_name: 'Austen', sort_name: 'Austen, Jane'

a01 = Item.create! code: 'B10001', name: 'Pride and Prejudice', category: y01, creator: r01, kind: 'Book',
                   format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10

Copy.create! item: a01, name: 'P118127340JA001', quality: 'n', status: 'a'
Copy.create! item: a01, name: 'P118127340JA002', quality: 'u', status: 'a'

p01 = Membership.create! code: '1001', name: 'Premium Members', kind: 'Premium'

Member.create! code: '1234', name: 'John Doe', membership: p01
