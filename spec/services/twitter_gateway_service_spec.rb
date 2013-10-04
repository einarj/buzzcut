require 'spec_helper'

describe TwitterGateway do
   let (:gateway) { TwitterGateway.new(nil, nil) }

  describe '#home_timeline' do
    #context 'oldest tweet is less than 30 days old' do
      #it 'should present a max_id parameter to the Twitter client' do
        #oldest_tweet = FactoryGirl.create(:tweet)
        #expect(oldest_tweet.published_on).to be >= 30.days.ago.to_date

        #double_client = double("Twitter::Client")
        #gateway.stub(:client).and_return(double_client)
        #double_client.should_receive(:home_timeline) do |opts|
          #expect(opts[:max_id]).to eq(oldest_tweet.tweet_id)
          #expect(opts[:since_id]).to be_nil
        #end
        #gateway.home_timeline
      #end
    #end

    context 'no existing tweets' do
      it 'should not present any boundary parameters to the Twitter client' do
        double_client = double("Twitter::Client")
        gateway.stub(:client).and_return(double_client)
        double_client.should_receive(:home_timeline) do |opts|
          expect(opts[:count]).to eq(200)
          expect(opts[:max_id]).to be_nil
          expect(opts[:since_id]).to be_nil
        end
        gateway.home_timeline
      end
    end

    context 'oldest tweet is more than 30 days old' do
      it 'should present a since_id parameter to the Twitter client' do
        oldest_tweet = FactoryGirl.create(:tweet, published_on: 31.days.ago.to_date)
        expect(oldest_tweet.published_on).to be < 30.days.ago.to_date

        double_client = double("Twitter::Client")
        gateway.stub(:client).and_return(double_client)
        double_client.should_receive(:home_timeline) do |opts|
          expect(opts[:since_id]).to eq(oldest_tweet.tweet_id)
          expect(opts[:max_id]).to be_nil
        end
        gateway.home_timeline
      end
    end
  end
end
