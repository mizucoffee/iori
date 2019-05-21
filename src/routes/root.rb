# / Router
class RootRouter < Base
  get '/' do
    erb :'routes/root'
  end

  get '/@:screen_name' do
    @twuser = Tw.app.user(params[:screen_name])
    @user = User.find_by(twitter_id: @twuser.id)
    erb :'routes/@user/root'
  end

  get '/@:screen_name/:review_id' do
    @review = Review.find_by(id: params[:review_id])

    error 404 if @review.blank?
    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    erb :'routes/@user/review'
  end

  get '/@:screen_name/:review_id/edit' do
    @review = Review.find_by(id: params[:review_id])
    @type = 'update'

    error 404 if @review.blank?
    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name] || @review.user.twitter_id == @me.twitter_id
      redirect '/'
    end

    erb :'routes/review/new'
  end

  get '/@:screen_name/:review_id/delete' do
    @review = Review.find_by(id: params[:review_id])

    error 404 if @review.blank?
    if Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name] && @review.user.twitter_id == @me.twitter_id
      @review.destroy
    end

    redirect '/'
  end

  get '/@:screen_name/:review_id/ogp.png' do
    @review = Review.find_by(id: params[:review_id])

    error 404 if @review.blank?
    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    svg = render :erb, :'svg/ogp', locals: { review: @review }
    res = Faraday.post 'https://svg2ogp.mizucoffee.net/', data: svg

    content_type :'image/png'
    res.body
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
