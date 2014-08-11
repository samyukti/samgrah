# This file is used to load history data for once into Samgrah.
# Please refer history.xlsx for the data format.
# The data can then be loaded with the rake db:history.

require 'rubyXL'

wb = RubyXL::Parser.parse('db/history.xlsx')

puts 'Loading Categories'
categories = OpenStruct.new(wb.worksheets[0].get_table)
categories[:table].each do |row|
  puts row

  category = OpenStruct.new(row)

  Category.create! code: category.code,
                   name: category.name,
                   kind: category.kind.to_s.underscore,
                   notes: category.notes
end

puts 'Loading Creators'
creators = OpenStruct.new(wb.worksheets[1].get_table)
creators[:table].each do |row|
  puts row

  creator = OpenStruct.new(row)

  Creator.create! kind: creator.kind.to_s.underscore,
                  first_name: creator.full_name,
                  middle_name: creator.full_name,
                  last_name: creator.full_name,
                  full_name: creator.full_name,
                  sort_name: creator.sort_name,
                  notes: creator.notes
end

puts 'Loading Items'
items = OpenStruct.new(wb.worksheets[2].get_table)
items[:table].each do |row|
  puts row

  item = OpenStruct.new(row)

  category = Category.where(code: item.category.to_s).first

  # two author columns and two editor columns in default history.xlsx
  # please change this code as required
  author_1 = Creator.where(sort_name: item.author_1.to_s).first.id if item.author_1
  author_2 = Creator.where(sort_name: item.author_2.to_s).first.id if item.author_2
  editor_1 = Creator.where(sort_name: item.editor_1.to_s).first.id if item.editor_1
  editor_2 = Creator.where(sort_name: item.editor_2.to_s).first.id if item.editor_2

  item_creators = []
  sequence      = 0
  item_creators << { sequence: sequence.next, creator_id: author_1, role: 'author' } if author_1
  item_creators << { sequence: sequence.next, creator_id: author_2, role: 'author' } if author_2
  item_creators << { sequence: sequence.next, creator_id: editor_1, role: 'editor' } if editor_1
  item_creators << { sequence: sequence.next, creator_id: editor_2, role: 'editor' } if editor_2

  Item.create! category: category,
               code: item.code,
               name: item.name,
               alt_name: item.alt_name,
               subject: item.subject,
               kind: item.kind.to_s.underscore,
               format: item.format.to_s.underscore,
               length: item.length.to_i,
               length_uom: 'pages',
               publisher: item.publisher,
               published_date: item.published_date,
               language: item.language.to_s.underscore,
               isbn_10: item.isbn_10,
               isbn_13: item.isbn_13,
               rights: item.rights.to_s.underscore,
               rating: item.rating.to_s,
               tags: item.tags,
               excerpt: item.excerpt,
               cost: item.cost,
               price: item.price,
               notes: item.notes,
               item_creators_attributes: item_creators
end

puts 'Loading Copies'
copies = OpenStruct.new(wb.worksheets[3].get_table)
copies[:table].each do |row|
  puts row

  copy = OpenStruct.new(row)

  item = Item.where(code: copy.item.to_s).first

  Copy.create! item: item,
               name: copy.code,
               procured_date: copy.procured_date,
               quality: copy.quality.to_s.underscore,
               quantity: copy.quantity,
               status: copy.status.to_s.underscore,
               issuable: copy.issuable,
               cost: copy.cost,
               price: copy.price,
               notes: copy.notes
end

puts 'Loading Membership'
memberships = OpenStruct.new(wb.worksheets[4].get_table)
memberships[:table].each do |row|
  puts row

  membership = OpenStruct.new(row)

  Membership.create! code: membership.code,
                     name: membership.name,
                     kind: membership.kind.to_s.underscore,
                     notes: membership.notes
end

puts 'Loading Members'
members = OpenStruct.new(wb.worksheets[5].get_table)
members[:table].each do |row|
  puts row

  member = OpenStruct.new(row)

  membership = Membership.where(code: member.membership.to_s).first
  address    = Address.new line_1: member.line_1.to_s,
                           line_2: member.line_2.to_s,
                           city: member.city.to_s,
                           state: member.state.to_s,
                           country: member.country.to_s,
                           postal_code: member.postal_code.to_s,
                           phone_1: member.phone.to_s,
                           mobile: member.mobile.to_s,
                           email_1: member.email.to_s

  Member.create! code: member.code,
                 name: member.name,
                 membership: membership,
                 kind: member.kind.to_s.underscore,
                 gender: member.gender.to_s.underscore,
                 age_group: member.age_group.to_s.underscore,
                 profession: member.profession,
                 join_date: member.join_date,
                 address: address
end
