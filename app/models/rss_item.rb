# -*- encoding : utf-8 -*-
class RssItem < ActiveRecord::Base
  default_scope :order => 'pub_date DESC'
end
