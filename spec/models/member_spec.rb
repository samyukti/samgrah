require 'spec_helper'

describe Member do
  it 'should have a name' do
    build(:member, name: nil).should_not be_valid
  end

  it 'should have a code' do
    build(:member, code: nil).should_not be_valid
  end

  it 'should not allow duplicate code' do
    create(:member, code: '1001')
    build(:member, code: '1001').should_not be_valid
  end

  it 'should have a membership' do
    build(:member, membership_id: nil).should_not be_valid
  end
end
