class TweetsController < ApplicationController

  MAX_ATTEMPTS = 3

  def update_all
    # If last tweet is old enough, get new tweets since then
    # TODO: Move into a background service
    # TODO: Expire too old tweets

    #gateway = TwitterGateway.new(session[:oauth_token], session[:oauth_token_secret])
    #feed_updater = FeedUpdater.new(gateway)
    #feed_updater.update_all

    #Resque.enqueue(UpdateFeedJob, session[:oauth_token], session[:oauth_token_secret])
    job = UpdateFeedJob.new
    job.schedule(session[:oauth_token], session[:oauth_token_secret])

    respond_to do |format|
      format.js
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  private

end
