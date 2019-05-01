# / Router
class RootRouter < Base
  get '/' do
    erb :index
  end

  get '/@:id' do
    @user = Tw.app.user(params[:id])
    erb :userpage
  end
end
