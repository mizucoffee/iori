# / Router
class RootRouter < Base
  get '/' do
    erb :'routes/root/root'
  end

  get '/@:screen_name' do
    @twuser = Tw.app.user(params[:screen_name])
    @user = User.find_by(twitter_id: @twuser.id)
    erb :'routes/root/user'
  end

  get '/@:screen_name/:review_id' do
    @review = Review.find(params[:review_id])
    pp @review

    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    erb :'routes/root/user_review'
  end
end
