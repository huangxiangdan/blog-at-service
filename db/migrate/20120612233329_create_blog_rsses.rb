# -*- encoding : utf-8 -*-
class CreateBlogRsses < ActiveRecord::Migration
  def change
    create_table :blog_rsses do |t|
      t.string :url
      t.string :username

      t.timestamps
    end
    add_index :blog_rsses, :url, :unique => true
  end
end
