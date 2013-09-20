class Tweet
  include Mongoid::Document
  field :published_on, :type => Date
  field :user, :type => Hash
  field :full_text, :type => String
  field :urls, :type => Array
  field :content, :type => Hash

  field :tweet_id, :type => Integer

  index({ tweet_id: 1 }, { unique: true, name: "tweet_id_index" })

  has_and_belongs_to_many :links


  def profile_image_url
    begin
      if user
        user['profile_image_url']
      elsif self.content["user"]
        self.content["user"]["profile_image_url"]
      else
        ""
      end
    rescue Exception => e
      debugger
      p e
    end
  end

  def text
    self.full_text || self.content['full_text'] || self.content["text"]
  end

  def self.exists?(tweet_id)
    Tweet.where(:tweet_id => tweet_id).count != 0
  end

  def self.create_from_twitter_tweet!(t)
    Tweet.create!(:tweet_id => t.id, :published_on => t.created_at, :user => t.user.to_hash, :full_text => t.full_text)
  end
end
