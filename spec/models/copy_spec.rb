require 'spec_helper'

describe Copy do
  it 'should have a name' do
    build(:copy, name: nil).should_not be_valid
  end

  it 'should have an item id' do
    build(:copy, item_id: nil).should_not be_valid
  end

  it 'should have quality information' do
    build(:copy, quality: nil).should_not be_valid
  end

  it 'should have a status' do
    build(:copy, status: nil).should_not be_valid
  end

  it 'should have a valid procured date' do
    build(:copy, procured_date: Date.today + 1).should_not be_valid
  end

  it 'should have default procured date of today for new records' do
    Copy.new.procured_date.should eql(Date.today)
  end

  it 'should have only one quantity if item is marked copywise' do
    item = create(:item, copywise: true)
    build(:copy, item: item, issuable: true, quantity: 2).should_not be_valid
  end

  it 'may have more quantities if it is not issuable' do
    build(:copy, issuable: false, quantity: 2).should be_valid
  end

  it 'defaults quantity to 1' do
    item = create(:item)
    create(:copy, item: item, issuable: false, quantity: nil).quantity.should eql(1)
  end

  it 'defaults attributes from item if not present' do
    item = create(:item)
    copy = create(:copy, item: item,
                         format: nil,
                         length: nil,
                         length_uom: nil,
                         publisher: nil,
                         published_date: nil,
                         cost: nil,
                         price: nil)
    copy.format.should eql(item.format)
    copy.length.should eql(item.length)
    copy.length_uom.should eql(item.length_uom)
    copy.publisher.should eql(item.publisher)
    copy.published_date.should eql(item.published_date)
    copy.cost.should eql(item.cost)
    copy.price.should eql(item.price)
  end

  it 'allows to change status only if the item is not issued' do
    build(:copy, issued_quantity: 1, status: 'unavailable').should_not be_valid
  end

  it 'shows the item image if does not have an cover image' do
    item = create(:item, photo: 'photo.jpg')
    copy = create(:copy, item: item, photo: nil)
    copy.image_url.should eql(item.photo.url)
  end

  it 'shows the default cover image if both copy and item do not have a cover image' do
    item = create(:item, photo: nil)
    copy = create(:copy, item: item, photo: nil)
    copy.image_url.should eql(ImageUploader.new.default_url)
  end
end
