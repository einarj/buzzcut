class CleanupExpiredTweets

  def run_cleanup
    Tweet.where(:published_on.lt => 30.days.ago).destroy
  end

end
