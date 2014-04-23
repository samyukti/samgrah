require 'spec_helper'

describe Member do
  it 'should have a name' do
    build(:member, name: nil).should_not be_valid
  end

  it 'should have a code' do
    build(:member, code: nil).should_not be_valid
  end

  it 'should have a kind' do
    build(:member, kind: nil).should_not be_valid
  end

  it 'should not allow duplicate code' do
    create(:member, code: '1001')
    build(:member, code: '1001').should_not be_valid
  end

  it 'should have a membership' do
    build(:member, membership_id: nil).should_not be_valid
  end

  it 'should not allow a closed date earlier than join date' do
    build(:member, join_date: Date.today, closed_date: Date.today - 1).should_not be_valid
  end

  it 'should not allow renewal earlier than join date' do
    build(:member, join_date: Date.today, renewed_date: Date.today - 1).should_not be_valid
  end

  it 'should not allow next renewal date earlier than join date' do
    build(:member, join_date: Date.today, renewal_date: Date.today - 1).should_not be_valid
  end

  it 'should not allow next renewal earlier than last renewal' do
    build(:member, renewed_date: Date.today, renewal_date: Date.today - 1).should_not be_valid
  end
end
