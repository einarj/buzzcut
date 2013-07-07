require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }

  it 'creates entry from auth hash' do
    auth_hash = {'info' => {'name' =>  'Samuel Vimes'} }
    expect {
      User.find_or_create_from_auth_hash(auth_hash)
    }.to change(User, :count).by(1)
  end

  it 'uses email when name is not in auth hash' do
    auth_hash = {'info' => {'email' =>  'vimes@citywatch.amp'} }
    expect {
      User.find_or_create_from_auth_hash(auth_hash)
    }.to change(User, :count).by(1)
  end

  it 'creates each user only once' do
    auth_hash = {'info' => {'email' =>  'vimes@citywatch.amp'} }
    expect {
      u1 = User.find_or_create_from_auth_hash(auth_hash)
      u2 = User.find_or_create_from_auth_hash(auth_hash)
      expect(u2).to eq(u1)
    }.to change(User, :count).by(1)

  end
end
