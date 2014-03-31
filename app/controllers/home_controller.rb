class HomeController < ApplicationController
  def index
    @items = Item.order('created_at desc').limit(8)
  end
end
