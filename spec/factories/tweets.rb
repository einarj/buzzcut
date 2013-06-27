FactoryGirl.define do
  factory :client_tweet, class: Twitter::Tweet do
    id 343752811177185280
    created_at Time.now
    #user  { FactoryGirl.build(:tweet_user) }
    full_text "Do startups discuss PRISM as a success metric at board meetings? \"Sadly, PRISM still hasn't asked us for access.\""
    #urls { FactoryGirl.build(:tweet_urls) }
  end

  #factory :tweet_user, class: Twitter::User do
    #id 9885102
    #id_str "9885102"
    #name "Dr Nic"
    #screen_name "drnic"
    #location "Palo Alto, CA"
    #description "Rails/Ruby/JavaScript developer. A developer's developer."
    #url "http://t.co/h8jUpTFSrw"
    #created_at Time.now
    #profile_image_url "http://a0.twimg.com/profile_images/2243751587/drnic_by_jeff_casimir_at_railsconf2010_-_thumbnail_normal.png"
  #end

  #factory :tweet_urls, class: Twitter::Entity::Url do
    #id 123
    #url "http://t.co/h8jUpTFSrw"
    #expanded_url "http://drnicwilliams.com"
    #display_url "drnicwilliams.com"
  #end

end
