require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have no User to begin with' do
    expect(User.count).to eq 0
  end

  it 'should create valid User instance with valid email and password' do
    expect(User.new(email: 'slepenkov.nii@yandex.by', password: '123456')).to be_valid
  end

  it 'should not be valid without email or password' do
    expect(User.new(email: 'slepenkov.nii@yandex.by')).to_not be_valid
    expect(User.new(password: '123456')).to_not be_valid
  end

  it 'should have one instance after adding one with valid data' do
    User.create(email: 'slepenkov.nii@yandex.by', password: '123456')
    expect(User.count).to eq 1
  end
end
