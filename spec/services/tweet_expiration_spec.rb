require 'spec_helper'

describe CleanupExpiredTweets do

  before do
    expired_client_tweet = FactoryGirl.build(:twitter_client_expired_tweet)
    @expired_tweet = Tweet.create_from_twitter_tweet!(expired_client_tweet)

    expired_client_tweet.urls.each do |u|
      tweet_url = TweetUrl.create!(u.attrs)

      link = Link.find_or_create_by(url: tweet_url.expanded_url)
      link.tweets << @expired_tweet
      link.save

      tweet_url.link = link
      tweet_url.tweet = @expired_tweet
      tweet_url.save
    end

    @cleaner = CleanupExpiredTweets.new
  end

  describe '#run_cleanup' do
    it 'deletes all expired tweets' do
      expect { @cleaner.run_cleanup }.to change{Tweet.count}.by(-1)
    end

    it 'removes the tweet association in from the links' do
      expect { @cleaner.run_cleanup }.to change{Link.first.tweets.count}.by(-1)
    end

    it 'deletes associated links' do
      @cleaner.run_cleanup
      expect(Link.first.tweet_count).to eq(0)
    end

    it 'deletes the associated TweetUrl' do
      expect { @cleaner.run_cleanup }.to change{TweetUrl.count}.by(-2)
    end
  end
end
