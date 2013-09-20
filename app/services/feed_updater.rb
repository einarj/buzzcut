class FeedUpdater

  def initialize(gateway)
    @gateway = gateway
  end

  def update_all
    # If last tweet is old enough, get new tweets since then
    # Expire too old tweets

    link = Link.first
    num_attempts = 0
    @gateway.home_timeline.each do |t|
      begin
        unless  Tweet.exists?(t.id)
          tweet = Tweet.create_from_twitter_tweet!(t)
          t.urls.each do |u|
            tweet_url = TweetUrl.create!(u.attrs)

            link = Link.find_or_create_by(url: tweet_url.expanded_url)
            link.tweets << tweet

            tweet_url.link = link
            tweet_url.tweet = tweet
          end
        end
      rescue Twitter::Error::TooManyRequests => error
        if num_attempts <= MAX_ATTEMPTS
          # NOTE: Your process could go to sleep for up to 15 minutes but if you
          #     # retry any sooner, it will almost certainly fail with the same exception.
          sleep error.rate_limit.reset_in
          retry
        else
          raise
        end
      rescue Exception => e
        p e
      end
    end

    #report_rate_limit
  end

end
