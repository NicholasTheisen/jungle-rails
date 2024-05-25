require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save a user with a password and password_confirmation fields' do
      @user = User.new(password: 'password', password_confirmation: 'password', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      expect(@user).to be_valid
    end

    it 'should not save a user with password and password_confirmation fields that do not match' do
      @user = User.new(password: 'password', password_confirmation: 'password1', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      expect(@user).to_not be_valid
    end

    it 'should not save a user without an email, first name, and last name' do
      @user = User.new(password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it 'should not save a user with an email that already exists (not case sensitive)' do
      @user1 = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      @user2 = User.new(password: 'password', password_confirmation: 'password', email: 'TEST@TEST.COM', first_name: 'First', last_name: 'Last')
      expect(@user2).to_not be_valid
    end

    it 'should not save a user with a password that is less than the minimum length' do
      @user = User.new(password: 'pass', password_confirmation: 'pass', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate a user with correct credentials' do
      @user = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq(@user)
    end

    it 'should not authenticate a user with incorrect credentials' do
      @user = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      expect(User.authenticate_with_credentials('test@test.com', 'wrongpassword')).to be_nil
    end

    it 'should authenticate a user with correct credentials and extra spaces around email' do
      @user = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      expect(User.authenticate_with_credentials('  test@test.com  ', 'password')).to eq(@user)
    end

    it 'should authenticate a user with correct credentials and wrong case for email' do
      @user = User.create(password: 'password', password_confirmation: 'password', email: 'test@test.com', first_name: 'First', last_name: 'Last')
      expect(User.authenticate_with_credentials('TEST@TEST.COM', 'password')).to eq(@user)
    end
  end
end