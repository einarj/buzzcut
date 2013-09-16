class TwitterGatewayService

  def home_timeline
    oldest = Tweet.asc(:published_on).first
    if oldest && oldest.published_on >= 30.days.ago.to_date
      # This should only be required during an initialization period
      p "FETCHING OLDER THAN #{Tweet.min(:tweet_id)}"
      client.home_timeline(:count => 200, :max_id => Tweet.min(:tweet_id))
    elsif oldest.nil? # Initializing
      client.home_timeline(:count => 200)
    else
      p "FETCHING NEWER THAN #{Tweet.max(:tweet_id)}"
      client.home_timeline(:count => 200, :since_id => Tweet.max(:tweet_id))
    end


  end

  def client
    Twitter::Client.new(:oauth_token => session[:oauth_token], :oauth_token_secret => session[:oauth_token_secret])
  end

  def report_rate_limit
    rate_limit = Twitter::RateLimit.new
    p """
    ################################################
    # RATE LIMIT STATUS
    # LIMIT: #{rate_limit.limit}
    # REMAINING: #{rate_limit.remaining}
    # RESET_AT: #{rate_limit.reset_at}
    # RESET_IN: #{rate_limit.reset_in} seconds
    ################################################
    """
  end
end
