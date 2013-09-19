FactoryGirl.define do
  factory :tweet do
    tweet_id 123456789012345678
    full_text "I guess it's time to ramble on"
    published_on Time.now.strftime("%a %b %d %H:%M:%S %z %Y")
  end

end
