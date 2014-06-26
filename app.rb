require "sinatra/base"
# require "sinatra/reloader"

class MyApp < Sinatra::Application
  # register Sinatra::Reloader

  def initialize
    super
    @items = ['item 1', 'item 2', 'item 3']
  end

  get '/' do
    erb :index, :locals => {:items => @items}
  end

  get "/items" do
    "Items #{@items.length}"
    erb :index, :locals => { :items => @items}
  end

  get "/items/new" do
    erb :new_item
  end

  post '/form' do
    item = params[:item]
    @items.push(item)
    erb :index, :locals => {:items => @items}
  end

  get "/items/:identifier" do
    identifier = params[:identifier].to_i
    if identifier == 42
      return 404
    end
    "You found: #{@items[identifier]}"
  end

  run! if app_file == $0
end
