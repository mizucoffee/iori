# /review Router
class ReviewRouter < Base
  get '/new' do
    redirect '/account/login?next=/review/new' if @me.nil?
    erb :'routes/review/new'
  end

  post '/new' do
    redirect '/account/login?next=/review/new' if @me.nil?
    r = Review.create(
      title: params[:title],
      body: params[:body],
      music: Music.find(params[:music]),
      hue: params[:hue],
      light: params[:light] == '1',
      review_type: 0,
      user: @me
    )
    @me.reviews << r
    @me.save
    redirect "/@#{@twitter.screen_name}/#{r.id}"
  end

  post '/update' do
    redirect '/account/login?next=/review/update' if @me.nil?
    r = Review.find(params[:id])

    r.title = params[:title]
    r.body = params[:body]
    r.music = Music.find(params[:music])
    r.hue = params[:hue]
    r.light = params[:light] == '1'
    r.review_type = 0

    r.save

    redirect "/@#{@twitter.screen_name}/#{r.id}"
  end
end
