require 'spec_helper'

describe Link do
  it { should validate_presence_of(:url) }
  it { should have_and_belong_to_many(:tweets) }
  it { should have_many(:tweet_urls) }
  it { should have_index_for(url: 1).with_options(unique: true, name: "url_index") }

  it 'updates its tweet count on update' do
    t = FactoryGirl.build(:client_tweet)
    tweet = Tweet.create!(:tweet_id => t.id, :published_on => t.created_at, :user => t.user.to_hash, :full_text => t.full_text)
    #tweet = FactoryGirl.build(:tweet)
    expect(@link).to receive(:update_tweet_count)
    #link.tweets << tweet
    #link.save!
    link = FactoryGirl.build(:link)
  end
end
