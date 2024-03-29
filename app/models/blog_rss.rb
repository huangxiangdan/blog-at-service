# -*- encoding : utf-8 -*-
class BlogRss < ActiveRecord::Base
  require "open-uri"
  has_many :rss_items, :foreign_key => 'rss_id'
  validates :url, :presence => true
  
  def is_valid?
    begin
      SimpleRSS.parse(open(url))  
    rescue Exception => ex
      puts ex
      false
    end
  end
end
