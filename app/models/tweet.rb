class Tweet
  include Mongoid::Document
  field :published_on, :type => Date
  field :user, :type => Hash
  field :full_text, :type => String
  field :urls, :type => Array
  field :content, :type => Hash

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
end
