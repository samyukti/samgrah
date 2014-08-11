# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'Seeding Default Users...'
admin = User.create! email: 'admin@samgrah.local', password: 'samyukti', password_confirmation: 'samyukti'

puts 'Seeding Default Roles...'
role_admin = Role.create! name: 'admin'
Role.create! name: 'auditor'
Role.create! name: 'manager'
Role.create! name: 'member'

puts 'Seeding Default User Role Associations...'
admin.roles << role_admin
