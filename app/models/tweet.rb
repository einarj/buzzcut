class Tweet
  include Mongoid::Document
  field :published_on, :type => DateTime
  field :user, :type => Hash
  field :full_text, :type => String
  field :urls, :type => Array
  field :content, :type => Hash

  field :tweet_id, :type => Integer

  index({ tweet_id: 1 }, { unique: true, name: "tweet_id_index" })

  has_and_belongs_to_many :links, dependent: :delete
  has_many :tweet_urls, dependent: :delete

  around_destroy :decrement_link_counters


  def decrement_link_counters
    link_ids = links.map(&:_id)
    yield
    link_ids.each { |link_id|
      link = Link.find(link_id)
      link.update_tweet_count
      link.save!
    }
  end

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

  def expired?
    self.published_on < 30.days.ago.to_date
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
