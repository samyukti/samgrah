require 'spec_helper'

describe Reservation do
  it 'should have an item' do
    build(:reservation, item_id: nil).should_not be_valid
  end

  it 'should have a member' do
    build(:reservation, member_id: nil).should_not be_valid
  end

  it 'should have a reserved date' do
    build(:reservation, reserved_date: nil).should_not be_valid
  end

  it 'should have a valid reserved date in present or past' do
    build(:reservation, reserved_date: Date.today + 1).should_not be_valid
  end

  it 'should have default reserved date of today for new records' do
    Reservation.new.reserved_date.should eql(Date.today)
  end

  it 'should not allow modification of a closed reservation'
  it 'should not allow modification of a canceled reservation'
end
