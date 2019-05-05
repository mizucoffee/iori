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

    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    erb :'routes/root/user_review'
  end

  get '/@:screen_name/:review_id/like' do
    @review = Review.find_by_id(params[:review_id])

    redirect '/' if @review.nil?

    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    p = {user: @me, review: @review}
    if @review.likes.find_by(p).nil?
      @review.likes.create(p)
    else
      @review.likes.find_by(p).destroy
    end

    redirect "/@#{params[:screen_name]}/#{params[:review_id]}"
  end
end
