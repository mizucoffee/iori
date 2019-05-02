# /review Router
class ReviewRouter < Base
  get '/new' do
    @genre = Genre.all
    redirect '/account/login?next=/review/new' if @me.nil?
    erb :review_new
  end

  post '/new' do
    r = Review.create({
      title: params[:title],
      body: params[:body],
      music: Music.find(params[:music]),
      color: params[:color],
      review_type: 0,
      user: @me
    })
    redirect "/@#{@twitter.screen_name}/#{r.id}"
  end
end
