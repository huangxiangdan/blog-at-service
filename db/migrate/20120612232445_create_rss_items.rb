# -*- encoding : utf-8 -*-
class CreateRssItems < ActiveRecord::Migration
  def change
    create_table :rss_items do |t|
      t.integer :rss_id
      t.string :title
      t.string :link
      t.datetime :pub_date
      t.string :at_list
      t.string :email_list

      t.timestamps
    end
  end
end
