require 'spec_helper'

describe Adjustment do
  it 'should have a copy' do
    build(:adjustment, copy_id: nil).should_not be_valid
  end

  it 'should have a valid adjusted date' do
    build(:adjustment, adjusted_date: nil).should_not be_valid
  end

  it 'should default adjusted date to today for new records' do
    Adjustment.new.adjusted_date.should eql(Date.today)
  end

  it 'should not have adjusted date in the past' do
    build(:adjustment, adjusted_date: Date.today - 1).should_not be_valid
  end

  it 'should have the return date less than adjusted date' do
    build(:adjustment, adjusted_date: Date.today, return_date: Date.today - 1).should_not be_valid
  end

  it 'should be able to save a valid record' do
    item = create(:item)
    copy = create(:copy, item: item)
    create(:adjustment, copy: copy)
  end

  it 'should not adjust an already issued copy' do
    item = create(:item)
    copy = create(:copy, item: item)
    member = create(:member)
    create(:issue, copy: copy, member: member)
    build(:adjustment, copy: copy).should_not be_valid
  end

  it 'should not adjust an already adjusted copy' do
    item = create(:item)
    copy = create(:copy, item: item)
    create(:adjustment, copy: copy)
    build(:adjustment, copy: copy).should_not be_valid
  end

  it 'should not adjust a copy which is marked unavailable' do
    # todo: create an adjustment record instead of unavailable status
    # item = create(:item)
    # copy = create(:copy, item: item, status: 'unavailable')
    # member = create(:member)
    # build(:adjustment, copy: copy, member: member).should_not be_valid
  end

  it 'should allow changing the adjustment details' do
    item = create(:item)
    copy = create(:copy, name: 'name', item: item)
    adjustment = create(:adjustment, copy: copy, adjusted_date: Date.today, return_date: Date.today + 7)
    adjustment.assign_attributes(adjusted_date: Date.today + 1, return_date: Date.today + 8)
    adjustment.save.should be(true)
  end

  it 'should not allow changing the copy of an adjustment' do
    item = create(:item)
    copy_1 = create(:copy, name: 'name_1', item: item)
    copy_2 = create(:copy, name: 'name_2', item: item)
    adjustment = create(:adjustment, copy: copy_1)
    adjustment.assign_attributes(copy: copy_2)
    adjustment.save.should be(false)
  end

  it 'should update the copy with adjusted quantity upon adjustment' do
    item = create(:item, copywise: false)
    copy = create(:copy, item: item, quantity: 2)
    create(:adjustment, copy: copy, adjusted_quantity: 2)
    copy.adjusted_quantity.should eql(2)
  end

  it 'should update the copy with adjusted quantity in copy upon close' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    adjustment = create(:adjustment, copy: copy)
    adjustment.close!
    copy.adjusted_quantity.should eql(0)
  end

  it 'should update the copy with adjusted quantity in copy upon cancellation' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    adjustment = create(:adjustment, copy: copy)
    adjustment.cancel!
    copy.adjusted_quantity.should eql(0)
  end

  it 'should set the returned date upon return of the copy' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    adjustment = create(:adjustment, copy: copy)
    adjustment.close!
    adjustment.returned_date.should eql(Date.today)
  end

  it 'should not set the returned date upon cancellation of the adjustment' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    adjustment = create(:adjustment, copy: copy)
    adjustment.cancel!
    adjustment.returned_date.should be_nil
  end

  it 'should save item of the copy along with adjustment for reporting purposes' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    adjustment = create(:adjustment, copy: copy)
    adjustment.item.should eql(item)
  end

  it 'should not allow modification of a closed adjustment'
  it 'should not allow modification of a canceled adjustment'
end
