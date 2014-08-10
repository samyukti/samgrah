require 'spec_helper'

describe Issue do
  it 'should have a copy' do
    build(:issue, copy_id: nil).should_not be_valid
  end

  it 'should have a member' do
    build(:issue, member_id: nil).should_not be_valid
  end

  it 'should have a valid issued date' do
    build(:issue, issued_date: nil).should_not be_valid
  end

  it 'should default issued date to today for new records' do
    Issue.new.issued_date.should eql(Date.today)
  end

  it 'should not have issued date in future' do
    build(:issue, issued_date: Date.today + 1).should_not be_valid
  end

  it 'should have a valid return date' do
    build(:issue, return_date: nil).should_not be_valid
  end

  it 'should have the return date less than issued date' do
    build(:issue, issued_date: Date.today, return_date: Date.today - 1).should_not be_valid
  end

  it 'should default return date to today plus configured period for new records' do
    Issue.new.return_date.should eql(Date.today + Settings.issue_period)
  end

  it 'should be able to save a valid record' do
    item = create(:item)
    copy = create(:copy, item: item)
    member = create(:member)
    create(:issue, copy: copy, member: member)
  end

  it 'should not issue an already issued copy' do
    item = create(:item)
    copy = create(:copy, item: item)
    member = create(:member)
    create(:issue, copy: copy, member: member)
    build(:issue, copy: copy, member: member).should_not be_valid
  end

  it 'should not issue a copy which is marked unavailable' do
    # todo: create an adjustment record instead of unavailable status
    # item = create(:item)
    # copy = create(:copy, item: item, status: 'unavailable')
    # member = create(:member)
    # build(:issue, copy: copy, member: member).should_not be_valid
  end

  it 'should not issue an item if all available copies are issued and/or reserved' do
    item = create(:item)
    create(:copy, name: 'name_1', item: item)
    # todo: create an adjustment record instead of unavailable status
    # create(:copy, name: 'name_2', item: item, status: 'unavailable')
    copy_1 = create(:copy, name: 'name_3', item: item)
    copy_2 = create(:copy, name: 'name_4', item: item)
    member = create(:member)
    create(:issue, copy: copy_1, member: member)
    2.times { create(:reservation, item: item, member: member) }
    item.reload
    build(:issue, copy: copy_2, member: member).should_not be_valid
  end

  it 'should allow changing the issue details' do
    item = create(:item)
    copy = create(:copy, name: 'name', item: item)
    member = create(:member)
    issue = create(:issue, copy: copy, member: member, issued_date: Date.today - 1, return_date: Date.today + 6)
    issue.assign_attributes(issued_date: Date.today, return_date: Date.today + 7)
    issue.save.should be(true)
  end

  it 'should not allow changing the copy of an issue' do
    item = create(:item)
    copy_1 = create(:copy, name: 'name_1', item: item)
    copy_2 = create(:copy, name: 'name_2', item: item)
    member = create(:member)
    issue = create(:issue, copy: copy_1, member: member)
    issue.assign_attributes(copy: copy_2)
    issue.save.should be(false)
  end

  it 'should mark the copy as issued upon issue' do
    item = create(:item)
    copy = create(:copy, item: item)
    create(:issue, copy: copy)
    copy.issued.should be(true)
  end

  it 'should unmark the issued flag in copy upon return' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    issue = create(:issue, copy: copy)
    issue.close!
    copy.issued.should be(false)
  end

  it 'should unmark the issued flag in copy upon cancellation of issue' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    issue = create(:issue, copy: copy)
    issue.cancel!
    copy.issued.should be(false)
  end

  it 'should set the returned date upon return of the copy' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    issue = create(:issue, copy: copy)
    issue.close!
    issue.returned_date.should eql(Date.today)
  end

  it 'should not set the returned date upon cancellation of the issue' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    issue = create(:issue, copy: copy)
    issue.cancel!
    issue.returned_date.should be_nil
  end

  it 'should save item of the copy along with issue for reporting purposes' do
    item  = create(:item)
    copy  = create(:copy, item: item)
    issue = create(:issue, copy: copy)
    issue.item.should eql(item)
  end

  it 'should not allow modification of a closed issue'
  it 'should not allow modification of a canceled issue'
end
