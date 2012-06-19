# -*- encoding : utf-8 -*-
namespace :parse do

  require "open-uri"
  require 'sqlite3'
  require 'rss'
  
  desc "process"
  task :process => :environment do
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)    
    oauth.authorize_from_access("e89ecb4e21b8f0ccc987b9bc9013c8e8", "eeb961c983124e9559b78f34a55ea3d8")
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

    author_name = blog_rss.username.blank? ? title : "@#{blog_rss.username} "
    last_rss_pub_date = blog_rss.rss_items.any? ? blog_rss.rss_items.first.pub_date : blog_rss.created_at

    items = feed.items.delete_if {|x| x.pubDate.to_i <= last_rss_pub_date.to_i}
    items = items.sort{|a, b|a.pubDate <=> b.pubDate}
    
    items.each_with_index do |item, i|
      at_list = []
      # puts item.pubDate.inspect
      # puts item.description
      item.description.scan(/@([0-9a-zA-Z\u4e00-\u9fff]+\s)/u) do |name|
        name = name.first
        # puts name
        # unless name.include?('，') || name.include?('。') || name.include?('？') || name.include?('（') || name.include?('）')
        next if at_list.include? "@#{name}"
        puts name
        at_list << "@#{name}"
        begin
          content = "@#{name},博客at工具提醒您, #{author_name}在文章#{item.link}中提到了您。"
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