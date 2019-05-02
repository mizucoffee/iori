# / Router
class RootRouter < Base
  get '/' do
    erb :index
  end

  get '/@:screen_name' do
    @twuser = Tw.app.user(params[:screen_name])
    @user = User.find_by(twitter_id: @twuser.id)
    erb :userpage
  end

  get '/@:screen_name/:review_id' do
    @review = Review.find(params[:review_id])

    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    erb :review
  end
end
