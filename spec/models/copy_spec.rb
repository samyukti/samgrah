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

  it 'should have only one quantity if it is issuable' do
    build(:copy, issuable: true, quantity: 2).should_not be_valid
  end

  it 'may have more quantities if it is not issuable' do
    build(:copy, issuable: false, quantity: 2).should be_valid
  end

  it 'defaults quantity date to 1' do
    create(:copy, issuable: false, quantity: nil).quantity.should eql(1)
  end

  it 'allows to change status only if the book is not issued' do
    build(:copy, issued: true, status: 'n').should_not be_valid
  end

  it 'shows the item image if does not have an cover image' do
    item = create(:item, photo: 'photo.jpg')
    copy = create(:copy, photo: nil)
    copy.image_url.should eql(item.photo.url)
  end

  it 'shows the default cover image if both copy and item do not have a cover image' do
    item = create(:item, photo: nil)
    copy = create(:copy, photo: nil)
    copy.image_url.should eql(ImageUploader.new.default_url)
  end
end
