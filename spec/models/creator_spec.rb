require 'spec_helper'

describe Creator do
  it 'should have a sort name' do
    build(:creator, sort_name: nil).should_not be_valid
  end

  it 'should not allow duplicate sort name' do
    create(:creator, sort_name: 'Austen, Jane')
    build(:creator, sort_name: 'Austen, Jane').should_not be_valid
  end

  it 'should have a kind' do
    build(:creator, kind: nil).should_not be_valid
  end
end
