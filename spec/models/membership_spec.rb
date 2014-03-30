require 'spec_helper'

describe Membership do
  it 'should have a name' do
    build(:membership, name: nil).should_not be_valid
  end

  it 'should have a code' do
    build(:membership, code: nil).should_not be_valid
  end

  it 'should have a kind' do
    build(:membership, kind: nil).should_not be_valid
  end

  it 'should not allow duplicate code' do
    create(:membership, code: '1234')
    build(:membership, code: '1234').should_not be_valid
  end

  it 'should not allow duplicate name' do
    create(:membership, name: 'Silver Class')
    build(:membership, name: 'Silver Class').should_not be_valid
  end
end
