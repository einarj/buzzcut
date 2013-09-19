require 'spec_helper'

describe FeedUpdater do

  before do
    # Create an array of Twitter::Tweet instances
    tweet1 = FactoryGirl.build(:twitter_client_tweet)
    tweet2 = FactoryGirl.build(:twitter_client_tweet2)

    # Stub gateway.home_timeline to return this array
    double_gateway = double(TwitterGateway)
    double_gateway.stub(:home_timeline).and_return([tweet1, tweet2])

    # Instantiate a feed updater using the stubbed gateway
    @feed_updater = FeedUpdater.new(double_gateway)
  end

  context 'new feeds to process' do
    it 'should create new Tweet records for each new tweet' do
      expect { @feed_updater.update_all }.to change{Tweet.count}.by(2)
    end

    it 'should create new TweetUrl instances for each new URL in the tweets' do
      expect { @feed_updater.update_all }.to change{TweetUrl.count}.by(4)
    end

    it 'should create a new Link for the URL if it does not exist' do
      expect { @feed_updater.update_all }.to change{Link.count}.by(2)
    end

    it 'should assign the tweet to the link' do
      @feed_updater.update_all
      tweets = Tweet.all

      Link.all.each { |link|
        expect(tweets[0].links).to include(link)
        expect(tweets[1].links).to include(link)
      }
    end

  end
end
