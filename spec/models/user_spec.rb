require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates uniqueness of username' do
      create(:user, username: 'testuser')
      duplicate_user = build(:user, username: 'testuser')
      expect(duplicate_user).not_to be_valid
    end
  end

  describe 'scopes' do
    it 'returns all users except the given user' do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      expect(User.all_except(user2)).to contain_exactly(user1, user3)
    end
  end

  describe 'associations' do
    it 'has many messages' do
      user = create(:user)
      expect(user.messages).to be_empty
      create(:message, user: user)
      expect(user.messages.count).to eq(1)
    end
  end

  xdescribe 'callbacks' do
    it 'broadcasts append to users after create' do
      expect {
        create(:user)
      }.to have_broadcasted_to("users").with(a_hash_including(action: :append))
    end
  end
end
