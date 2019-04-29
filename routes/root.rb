require './routes/base.rb'

# / Router
class Root < Base
  get '/' do
    erb :index
  end

  get '/@:id' do
    @user = params[:id]
    erb :userpage
  end
end
