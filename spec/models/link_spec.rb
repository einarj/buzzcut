require 'spec_helper'

describe Link do
  it { should validate_presence_of(:url) }
  it { should have_and_belong_to_many(:tweets) }
  it { should have_many(:tweet_urls) }
  it { should have_index_for(url: 1).with_options(unique: true, name: "url_index") }
end
