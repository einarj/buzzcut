class DeleteExpiredTweetsJob
  def self.queue; :app; end

  def self.perform
    p "Running the cleaner!"
    cleaner = CleanupExpiredTweets.new
    cleaner.run_cleanup
    p "Done cleaning for now."
  end
end
