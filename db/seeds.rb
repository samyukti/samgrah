# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'Seeding Default Users...'
admin = User.create! email: 'admin@sangrah.local', password: 'samyukti', password_confirmation: 'samyukti'

puts 'Seeding Default Roles...'
role_admin = Role.create! name: 'admin'
Role.create! name: 'auditor'
Role.create! name: 'manager'
Role.create! name: 'member'

puts 'Seeding Default User Role Associations...'
admin.roles << role_admin

puts 'Seeding Demo Data...'
Category.create! code: '1001', name: 'Classics', kind: 'Literature'

jane_austen = Creator.create! kind: 'Author', first_name: 'Jane', last_name: 'Austen', sort_name: 'Austen, Jane'
charlotte_bronte = Creator.create! kind: 'Author', first_name: 'Charlotte', last_name: 'Brontë', sort_name: 'Brontë, Charlotte'
emily_bronte = Creator.create! kind: 'Author', first_name: 'Emily', last_name: 'Brontë', sort_name: 'Brontë, Emily'
oscar_wilde = Creator.create! kind: 'Author', first_name: 'Oscar', last_name: 'Wilde', sort_name: 'Wilde, Oscar'
william_shakespeare = Creator.create! kind: 'Author', first_name: 'William', last_name: 'Shakespeare', sort_name: 'Shakespeare, William'
charles_dickens = Creator.create! kind: 'Author', first_name: 'Charles', last_name: 'Dickens', sort_name: 'Dickens, Charles'

Item.create! code: 'B10001', name: 'Pride and Prejudice', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: jane_austen.id, role: 'Author' }]
Item.create! code: 'B10002', name: 'Jane Eyre', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: charlotte_bronte.id, role: 'Author' }]
Item.create! code: 'B10003', name: 'Wuthering Heights', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: emily_bronte.id, role: 'Author' }]
Item.create! code: 'B10004', name: 'Sense and Sensibility', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: jane_austen.id, role: 'Author' }]
Item.create! code: 'B10005', name: 'The Picture of Dorian Gray', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: oscar_wilde.id, role: 'Author' }]
Item.create! code: 'B10006', name: 'Emma', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: jane_austen.id, role: 'Author' }]
Item.create! code: 'B10007', name: 'Romeo and Juliet', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: william_shakespeare.id, role: 'Author' }]
Item.create! code: 'B10008', name: 'Oliver Twist', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: charles_dickens.id, role: 'Author' }]
Item.create! code: 'B10009', name: 'Persuasion', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: jane_austen.id, role: 'Author' }]
Item.create! code: 'B10010', name: 'Mansfield Park', category: Category.first, kind: 'Book',
             format: 'Paperback', language: 'English', rights: 'Public Domain', rating: 10, excerpt: %q(Lorem ipsum dolor sit amet, consectetur adipiscing elit. aenean fermentum ligula eu vestibulum cursus.),
             item_creators_attributes: [{ creator_id: jane_austen.id, role: 'Author' }]

Copy.create! item: Item.first, name: 'P118127340JA001', quality: 'n', status: 'a'
Copy.create! item: Item.first, name: 'P118127340JA002', quality: 'u', status: 'a'

Membership.create! code: '1001', name: 'Premium Members', kind: 'Premium'

Member.create! code: '1234', name: 'John Doe', membership: Membership.first, address: Address.create!
