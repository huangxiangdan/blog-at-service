# -*- encoding : utf-8 -*-
class BlogRss < ActiveRecord::Base
  require "open-uri"
  validates :url, :presence => true
  
  def is_valid?
    begin
      feed = SimpleRSS.parse(open(url))  
      feed && feed.channel
    rescue Exception => ex
      puts ex
      false
    end
  end
end
