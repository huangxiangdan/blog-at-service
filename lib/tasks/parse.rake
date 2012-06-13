# -*- encoding : utf-8 -*-
namespace :parse do

  require "open-uri"
  require 'sqlite3'
  require 'rss'
  
  desc "process"
  task :process => :environment do
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)    
    oauth.authorize_from_access("aadd2a1ee9fbf01270c34d6cec808a61", "bc4a7efbbab850bd28550eeae89f0a6a")
    weibo_api = Weibo::Base.new(oauth)
    BlogRss.find_each do |rss|
      send_at_message(weibo_api, rss)
    end
  end
  
  private 
  def send_at_message(weibo_api, blog_rss)
    feed = RSS::Parser.parse(open(blog_rss.url).read, false)   
    # puts feed.inspect
    # puts feed.channel.lastBuildDate
    title = feed.channel.title
    
    items = feed.items.sort{|a, b|b.pubDate <=> a.pubDate}
    
    items.each_with_index do |item, i|
      break if item.pubDate < blog_rss.created_at
      break if RssItem.all.first && item.pubDate <= RssItem.all.first.pub_date
      at_list = []
      # puts item.pubDate.inspect
      # puts item.description
      item.description.scan(/@([0-9a-zA-Z\u4e00-\u9fff]+\s)/u) do |name|
        name = name.first
        # puts name
        # unless name.include?('，') || name.include?('。') || name.include?('？') || name.include?('（') || name.include?('）')
        puts name
        at_list << "@#{name}"
        begin
          content = "@#{name},博客at工具提醒您, #{title}在文章#{item.link}中提到了您。"
          puts content
          weibo_api.update(content)
          sleep(5)
        rescue Exception => ex
          puts ex
        #   end
        end
      end
      RssItem.create(:rss_id => blog_rss.id, :title => item.title, :link => item.link, :pub_date => item.pubDate.to_s, :at_list => at_list.join(','))
    end
  end
end