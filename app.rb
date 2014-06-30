require "sinatra/base"
# require "sinatra/reloader"

class MyApp < Sinatra::Application
  # register Sinatra::Reloader
  @search_items = []
  def initialize
    super
    @items = ['apple', 'anteater', 'ant']
  end

  get '/' do
    # @search_items = nil
    erb :index, :locals => {:items => @items, :search_items => @search_items}
  end

  get "/items" do
    "Items #{@items.length}"
    erb :index, :locals => { :items => @items, :search_items => @search_items}
  end

  get "/items/new" do
    erb :new_item
  end

  post '/items' do
    item = params[:item]
    @items.push(item)
    erb :index, :locals  => {:items => @items, :search_items => @search_items}
  end

  post '/search' do
    search = params[:search]
    items = @items.select{|item| item.downcase.include? search.downcase}
    @search_items = items.dup
    erb :search, :locals => {:items => items, :search_items => @search_items}
  end

  get '/search' do
    @items = params[:items]
  end

  get "/items/:identifier" do
    @items.length
    @search_items
    @identifier = params[:identifier].to_i
    # if params[:identifier].to_i >= items.length
    element = 2
    if @identifier == 42
      return 404
    end
    erb :item_identifier, :locals => {:item => @identifier, :element => element}
    # erb :item_identifier, :locals => {:item => @identifier}
  end

  run! if app_file == $0
end
