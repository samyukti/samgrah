require 'spec_helper'

describe Receipt do
  it 'should have a member' do
    build(:receipt, member_id: nil).should_not be_valid
  end

  it 'should have a kind' do
    build(:receipt, kind: nil).should_not be_valid
  end

  it 'should have a mode' do
    build(:receipt, mode: nil).should_not be_valid
  end

  it 'should have a valid received date' do
    build(:receipt, received_date: nil).should_not be_valid
  end

  it 'should default received date to today for new records' do
    Receipt.new.received_date.should eql(Date.today)
  end

  it 'should not have received date in future' do
    build(:receipt, received_date: Date.today + 1).should_not be_valid
  end
end
