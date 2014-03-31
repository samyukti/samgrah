class HomeController < ApplicationController
  def index
    @items = Item.order('created_at desc').limit(8)
  end

  def about
  end

  def policies
  end

  def items
    @items = Item.page(params[:page]).per(12)
  end
end
