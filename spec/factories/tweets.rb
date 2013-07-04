FactoryGirl.define do
  factory :client_tweet, class: Twitter::Tweet do
    initialize_with { new(
      id: 123456789012345678,
      full_text: "I guess it's time to ramble on",
      created_at: Time.now.strftime("%a %b %d %H:%M:%S %z %Y"),
      user:  FactoryGirl.build(:tweet_user)
    ) }
  end

  factory :tweet_user, class: Twitter::User do
    initialize_with { new(
    id: 9885102,
    id_str: "9885102",
    name: "Dr Nic",
    screen_name: "drnic",
    location: "Palo Alto, CA",
    description: "Rails/Ruby/JavaScript developer. A developer's developer.",
    url: "http://t.co/h8jUpTFSrw",
    created_at: Time.now,
    profile_image_url: "http://a0.twimg.com/profile_images/2243751587/drnic_by_jeff_casimir_at_railsconf2010_-_thumbnail_normal.png"
    ) }
  end

  #factory :tweet_urls, class: Twitter::Entity::Url do
    #id 123
    #url "http://t.co/h8jUpTFSrw"
    #expanded_url "http://drnicwilliams.com"
    #display_url "drnicwilliams.com"
  #end

end
