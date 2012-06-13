# -*- encoding : utf-8 -*-
class BlogRssesController < ApplicationController
  include SessionsHelper
  before_filter :web_auth, :only => [:destroy]
  # GET /blog_rsses
  # GET /blog_rsses.json
  def index
    @blog_rsses = BlogRss.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @blog_rsses }
    end
  end

  # GET /blog_rsses/1
  # GET /blog_rsses/1.json
  def show
    @blog_rss = BlogRss.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @blog_rss }
    end
  end

  # GET /blog_rsses/new
  # GET /blog_rsses/new.json
  def new
    @blog_rss = BlogRss.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @blog_rss }
    end
  end

  # POST /blog_rsses
  # POST /blog_rsses.json
  def create
    @blog_rss = BlogRss.new(params[:blog_rss])
    if @blog_rss.is_valid?
      success = true
    else
      flash[:notice] = "rss 地址不合法或此刻无法链接"
    end
    respond_to do |format|
      if success && @blog_rss.save
        format.html { redirect_to @blog_rss, :notice => 'Blog rss was successfully created.' }
        format.json { render :json => @blog_rss, :status => :created, :location => @blog_rss }
      else
        format.html { render :action => "new" }
        format.json { render :json => @blog_rss.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog_rss = BlogRss.find(params[:id])

    @blog_rss.destroy
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => @blog_rss }
    end
  end
end
