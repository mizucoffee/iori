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
    error 404 unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]

    erb :'routes/@user/review'
  end

  get '/@:screen_name/:review_id/edit' do
    @review = Review.find_by(id: params[:review_id])
    @type = 'update'

    redirect "/@#{params[:screen_name]}/#{params[:review_id]}" if @review.blank?
    redirect "/@#{params[:screen_name]}/#{params[:review_id]}" unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
    error 403 unless @review.user.twitter_id == @me.twitter_id

    erb :'routes/review/new'
  end

  get '/@:screen_name/:review_id/delete' do
    @review = Review.find_by(id: params[:review_id])

    redirect "/@#{params[:screen_name]}/#{params[:review_id]}" if @review.blank?
    redirect "/@#{params[:screen_name]}/#{params[:review_id]}" unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
    error 403 unless @review.user.twitter_id == @me.twitter_id

    @review.destroy
    redirect '/'
  end

  get '/@:screen_name/:review_id/ogp.png' do
    @review = Review.find_by(id: params[:review_id])

    error 404 if @review.blank?
    error 404 unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]

    svg = render :erb, :'svg/ogp', locals: { review: @review }
    res = Faraday.post 'https://svg2ogp.mizucoffee.net/', data: svg

    content_type :'image/png'
    res.body
  end

  get '/@:screen_name/:review_id/like' do
    @review = Review.find_by_id(params[:review_id])

    redirect "/@#{params[:screen_name]}/#{params[:review_id]}" if @review.blank?
    redirect "/@#{params[:screen_name]}/#{params[:review_id]}" unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]

    p = { user: @me, review: @review }
    if @review.likes.find_by(p).nil?
      @review.likes.create(p)
    else
      @review.likes.find_by(p).destroy
    end

    redirect "/@#{params[:screen_name]}/#{params[:review_id]}"
  end
end
